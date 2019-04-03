require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'
require 'pry'

class MuseumTest < Minitest::Test

  def test_museum_exists
    dmns = Museum.new("Denver Museum of Nature and Science")

    expected = Museum
    actual = dmns
    assert_instance_of expected, actual
  end

  def test_museum_has_name
    dmns = Museum.new("Denver Museum of Nature and Science")

    expected = "Denver Museum of Nature and Science"
    actual = dmns.name
    assert_equal expected, actual
  end

  def test_museum_has_no_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")

    expected = []
    actual = dmns.exhibits
    assert_equal expected, actual
  end

  def test_museum_can_add_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    imax = Exhibit.new("IMAX", 15)
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expected = [gems_and_minerals, dead_sea_scrolls, imax]
    actual = dmns.exhibits
    assert_equal expected, actual
  end

  def test_museum_can_recommend_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    imax = Exhibit.new("IMAX", 15)
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    bob = Patron.new("Bob", 20)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Gems and Minerals")

    sally = Patron.new("Sally", 20)
    sally.add_interest("IMAX")


    expected = [gems_and_minerals, dead_sea_scrolls]
    actual = dmns.recommend_exhibits(bob)
    assert_equal expected, actual
  end

  def test_museum_can_recommend_exhibits_to_someone_else
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    imax = Exhibit.new("IMAX", 15)
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    bob = Patron.new("Bob", 20)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Gems and Minerals")

    sally = Patron.new("Sally", 20)
    sally.add_interest("IMAX")


    expected = [imax]
    actual = dmns.recommend_exhibits(sally)
    assert_equal expected, actual
  end





end
