class Quiz
  attr_reader :hash_quiz
  attr_accessor :ordered
  def initialize
    @hash_quiz = Hash.new("")

    @hash_quiz["What is the only even prime?"] = "2"
    @hash_quiz["What is the only even prime's squared?"] = "4"
    @hash_quiz['What is the only cube integer less than 10 greater than 1?'] = "8"

    @files_read = []
    @quiz_displayed = []
    @ordered = true
  end

  def get_quiz
    return "" if @hash_quiz.empty?

    questions = @hash_quiz.keys
    
    while i = rand(questions.length)
      unless @quiz_displayed.include? i
        @quiz_displayed << i
        @quiz_displayed.clear if @quiz_displayed.length == questions.length
        break
      end
    end
    msg = @quiz_displayed.empty? ? "**That is the last of the question-answer pair." : ""
    "#{questions[i]}: \n#{@hash_quiz[questions[i]]}\n#{msg}"

  end

  def read_in_more(path_to_qa)
    return "No file path provided." if path_to_qa.empty?
    return "This file was already added." if @files_read.include?(path_to_qa)

    counter = 0
    is_question = true
    question = ""
    answer = ""

    begin
        File.foreach(path_to_qa) do |line|
            if line.include?("==question")
                is_question = true
            elsif line.include?("==answer")
                is_question = false
            elsif line.include?("==end")
                unless question.empty? && answer.empty?
                    @hash_quiz[question] = answer 
                    question = ""
                    answer = ""
                    counter += 1
                end
                
            else
                question += line.chomp if is_question
                answer += line.chomp unless is_question
            end
        end

        @files_read << path_to_qa
        "\n**#{counter} questions and answers have been added from file at #{path_to_qa}.\n\n"
    rescue
        "There was a problem. Only #{counter} questions and answers have been added from file at #{path_to_qa}."
    end
  end
end