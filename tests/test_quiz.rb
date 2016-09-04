require_relative '../quiz'
require 'minitest/autorun'

class TestQuiz < Minitest::Test
  def setup
    @quiz = Quiz.new
  end

  def test_default_quiz
    refute_empty @quiz.get_quiz, "New Quiz instance should have default quizzes"
  end

  def test_add_a_quiz
    initial_length = @quiz.number_of_quizzes
    @quiz.add_quiz('What is binary 1010 in base 10?', '10')
    new_length = @quiz.number_of_quizzes
    refute_equal initial_length, new_length, 'A new quiz has been added'
  end

  def test_add_empty_question
    initial_size = @quiz.number_of_quizzes
    @quiz.add_quiz('','foo')
    new_size = @quiz.number_of_quizzes
    assert_equal initial_size, new_size, 'No quiz added when question parameter is empty'
  end

  def test_add_empty_answer
    initial_size = @quiz.number_of_quizzes
    @quiz.add_quiz('bar','')
    new_size = @quiz.number_of_quizzes
    assert_equal initial_size, new_size, 'No quiz added when answer parameter is empty'
  end

  def test_get_quiz
    q = @quiz.get_quiz
    refute_empty q, "Quiz object should be able to get a quiz"
  end

  def test_read_from_file
    initial_size = @quiz.number_of_quizzes
    @quiz.read_in_more(__FILE__.sub(/test_quiz\.rb/, 'sample_test_quiz.txt'))
    refute_equal initial_size, @quiz.number_of_quizzes, 'New quizzes added from the given file'
  end

  def test_last_quiz
    size = @quiz.number_of_quizzes
    (size - 1).times { @quiz.get_quiz }
    q = @quiz.get_quiz
    assert q.include?('last of the question-answer pair'), 'Last quiz should have message indicating it is the last'
  end

  def test_quiz_hash_readable
    refute_nil @quiz.hash_quiz, 'Quiz hash is readable'
  end

  def test_quiz_hash_not_writeable
    initial_size = @quiz.hash_quiz.size
    @quiz.hash_quiz['foo'] = 'bar'
    new_size = @quiz.hash_quiz.size
    assert_equal initial_size, new_size
  end
end
