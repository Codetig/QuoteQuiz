require_relative 'quiz'
require 'minitest/autorun'

class TestQuiz < Minitest::Test
  def setup
    @quiz = Quiz.new
  end

  def test_default_quiz
    #puts @quiz.get_quiz
    refute_empty @quiz.get_quiz, "New Quiz instance should have default quizzes"
  end

  def test_add_a_quiz
    initial_length = @quiz.number_of_quizzes
    @quiz.add_quiz('What is binary 1010 in base 10?', '10')
    new_length = @quiz.number_of_quizzes
    assert_equal(true, new_length > initial_length)
  end

  def test_get_quiz
    q = @quiz.get_quiz
    refute_empty q, "Quiz object should be able to get a quiz"
  end

  def test_read_from_file
    initial_size = @quiz.number_of_quizzes
    @quiz.read_in_more("./sample_test_quiz.txt")
    new_size = @quiz.number_of_quizzes
    assert_equal(true, new_size > initial_size)
  end
end
