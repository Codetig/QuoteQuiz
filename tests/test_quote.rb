require_relative '../quote'
require 'minitest/autorun'

class TestQuote < MiniTest::Test
  def setup
    @quote = Quote.new
  end

  def test_new_quote
    refute_empty(@quote.get_quote, "There should be initial quotes.")
  end

  def test_identify_last_quote
    cache = []
    num = @quote.number_of_quotes
    num.times { cache << @quote.get_quote }

    assert_equal cache.last.include?('the last quote'), true   
  end

  def test_quote_addition
    initial_num = @quote.number_of_quotes
    @quote.add_quote('It never rains, it pours!')
    new_num = @quote.number_of_quotes
    
    assert(new_num > initial_num, 'The number of quizzes should be unchanged')
  end
end
