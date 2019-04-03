require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'
require 'pry'

class PatronTest < Minitest::Test

  def test_patron_exists
    bob = Patron.new("Bob", 20)

    expected = Patron
    actual = bob
    assert_instance_of expected, actual
  end

  def test_patron_has_name
    bob = Patron.new("Bob", 20)

    expected = "Bob"
    actual = bob.name
    assert_equal expected, actual
  end

  def test_patron_starts_with_20_spending_money
    bob = Patron.new("Bob", 20)

    expected = 20
    actual = bob.spending_money
    assert_equal expected, actual
  end

  def test_patron_starts_with_no_interests
    bob = Patron.new("Bob", 20)

    expected = []
    actual = bob.interests
    assert_equal expected, actual
  end

  def test_patron_interests_added
    bob = Patron.new("Bob", 20)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Gems and Minerals")

    expected = ["Dead Sea Scrolls", "Gems and Minerals"]
    actual = bob.interests
    assert_equal expected, actual
  end

end
