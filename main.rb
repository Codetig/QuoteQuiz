require_relative "quote"
require_relative "quiz"

puts "Would you like to use quizzes or quotes: (enter quiz or quote)"
input = gets.chomp
q = input == "quote" ? Quote.new : Quiz.new
q_str = input == "quiz" ? 'quizzes' : 'quotes'

is_done = false

puts "Please add the path to file containing #{q_str} you want to add: (or just press return)"
other_qs = gets.chomp
puts q.read_in_more(other_qs) unless other_qs.empty?
puts '**No file paths added**' if other_qs.empty?

until is_done
    puts q.get_quote, "\n" if input == 'quote'
    puts q.get_quiz, "\n" if input == 'quiz'
    puts "Another? (Y/n)"
    resp = gets.chomp
    is_done = true if resp != "Y"
end