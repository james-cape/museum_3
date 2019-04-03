require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'
require 'pry'

class ExhibitTest < Minitest::Test


  def test_exhibit_exists
    exhibit = Exhibit.new("Gems and Minerals", 0)

    expected = Exhibit
    actual = exhibit
    assert_instance_of expected, actual
  end

  def test_exhibit_has_name
    exhibit = Exhibit.new("Gems and Minerals", 0)

    expected = "Gems and Minerals"
    actual = exhibit.name
    assert_equal expected, actual
  end

  def test_exhibit_starts_with_0_cost
    exhibit = Exhibit.new("Gems and Minerals", 0)

    expected = 0
    actual = exhibit.cost
    assert_equal expected, actual
  end

end
