class Quote
    attr_reader :arr_quotes
    def initialize
        #perhaps use an input file for this
        @arr_quotes = [
            "Foo! Bar!", 
            "Do you parse the the words coming out of my mouth.",
            "Leonardo of Pisa introduced the Fibonacci Sequence to the Western European Mathematics"
            ]

        @hash_quiz = Hash.new("")

        @files_read = []
        @quotes_displayed = []
    end

    def number_of_quotes
        @arr_quotes.length
    end
    
    def get_quote
        while num = rand(@arr_quotes.length)
            unless @quotes_displayed.include?(num)
                @quotes_displayed << num
                @quotes_displayed.clear if @quotes_displayed.length == @arr_quotes.length
                break
            end
        end
        
        msg = @quotes_displayed.empty? ? "\n**That is the last quote.**" : ""
        @arr_quotes[num] + msg
    end

    def add_quote new_quote
        @arr_quotes << new_quote
    end
    
    def read_in_more(quote_file_path)
        return "This file was already added." unless @files_read || !@files_read.include?(quote_file_path)
        counter = 0
        quote_str = ""

        begin
            File.foreach(quote_file_path) do |line|
                if line.include?("==end") || line.nil?
                    @arr_quotes << quote_str
                    counter += 1 unless quote_str.empty?
                    quote_str = "" # quote_str.clear prevents adding string to array
                else

                    quote_str += line
                end
            end
        rescue
            @arr_quotes = @arr_quotes[0...(-counter)]
            return "There was a problem loading your file"
        end

        @files_read << quote_file_path
        "#{counter} quotes added.\n\n"
    end
end

