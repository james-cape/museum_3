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


    expected = [dead_sea_scrolls, gems_and_minerals]
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

  def test_museum_starts_with_no_patrons
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    imax = Exhibit.new("IMAX", 15)
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expected = []
    actual = dmns.patrons
    assert_equal expected, actual
  end

  def test_museum_builds_array_of_patrons
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
    sally.add_interest("Dead Sea Scrolls")

    dmns.admit(bob)
    dmns.admit(sally)

    expected = [bob, sally]
    actual = dmns.patrons
    assert_equal expected, actual
  end

  def test_museum_knows_patrons_by_exhibit_interest
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
    sally.add_interest("Dead Sea Scrolls")

    dmns.admit(bob)
    dmns.admit(sally)


    expected = {gems_and_minerals => [bob], dead_sea_scrolls => [bob,sally], imax => [sally]}
    actual = dmns.patrons_by_exhibit_interest
    assert_equal expected, actual
  end

  def test_tj_has_7_spending_money
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    imax = Exhibit.new("IMAX", 15)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(imax)
    dmns.add_exhibit(dead_sea_scrolls)

    # This Patron is interested in two exhibits but none in their price range, so they attend none
    tj = Patron.new("TJ", 7)
    tj.add_interest("IMAX")
    tj.add_interest("Dead Sea Scrolls")
    dmns.admit(tj)



    assert_equal 7, tj.spending_money
    assert_equal 0, dmns.revenue
  end

  def test_bob_only_attends_single_exhibit_in_his_price_range
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    imax = Exhibit.new("IMAX", 15)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(imax)
    dmns.add_exhibit(dead_sea_scrolls)

    # This Patron is interested in two exhibits and only Dead Sea Scrolls
    # is in their price range price, so they attend Dead Sea Scrolls
    bob = Patron.new("Bob", 10)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("IMAX")
    dmns.admit(bob)

    assert_equal 0, bob.spending_money
    assert_equal 10, dmns.revenue
  end

  def test_sally
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    imax = Exhibit.new("IMAX", 15)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(imax)
    dmns.add_exhibit(dead_sea_scrolls)

    sally = Patron.new("Sally", 20)
    sally.add_interest("Dead Sea Scrolls")
    sally.add_interest("IMAX")
    dmns.admit(sally)

    assert_equal 5, sally.spending_money
  end

  def test_morgan_attends_two_exhibits_within_range
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    imax = Exhibit.new("IMAX", 15)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(imax)
    dmns.add_exhibit(dead_sea_scrolls)

    # This Patron is interested in two exhibits and both are in their price range.
    # They have enough spending money to afford both, so they attend both.
    morgan = Patron.new("Morgan", 15)
    morgan.add_interest("Gems and Minerals")
    morgan.add_interest("Dead Sea Scrolls")
    dmns.admit(morgan)


    assert_equal 5, morgan.spending_money
    assert_equal 10, dmns.revenue
  end

  def test_patrons_of_exhibits

    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    imax = Exhibit.new("IMAX", 15)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(imax)
    dmns.add_exhibit(dead_sea_scrolls)

    # This Patron is interested in two exhibits but none in their price range, so they attend none
    tj = Patron.new("TJ", 7)
    tj.add_interest("IMAX")
    tj.add_interest("Dead Sea Scrolls")
    dmns.admit(tj)

    # This Patron is interested in two exhibits and only Dead Sea Scrolls
    # is in their price range price, so they attend Dead Sea Scrolls
    bob = Patron.new("Bob", 10)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("IMAX")
    dmns.admit(bob)

    # This Patron is interested in two exhibits and both are in their price range.
    # They have enough spending money to afford both, so they attend both.
    morgan = Patron.new("Morgan", 15)
    morgan.add_interest("Gems and Minerals")
    morgan.add_interest("Dead Sea Scrolls")
    dmns.admit(morgan)

    sally = Patron.new("Sally", 20)
    sally.add_interest("Dead Sea Scrolls")
    sally.add_interest("IMAX")
    dmns.admit(sally)

    assert_equal 35, dmns.revenue
    #expected = {#<Exhibit:0xXXXXXX @name="Dead Sea Scrolls", @cost=10>=>[#<Patron:0xXXXXXX @name="Morgan", @spending_money=5, @interests=["Gems and Minerals", "Dead Sea Scrolls"]>, #<Patron:0xXXXXXX @name="Morgan", @spending_money=5, @interests=["Gems and Minerals", "Dead Sea Scrolls"]>], #<Exhibit:0xXXXXXX @name="Gems and Minerals", @cost=0>=>[#<Patron:0xXXXXXX @name="Morgan", @spending_money=5, @interests=["Gems and Minerals", "Dead Sea Scrolls"]>, #<Patron:0xXXXXXX @name="Morgan", @spending_money=5, @interests=["Gems and Minerals", "Dead Sea Scrolls"]>], #<Exhibit:0xXXXXXX @name="IMAX", @cost=15>=>[#<Patron:0xXXXXXX @name="Sally", @spending_money=5, @interests=["Dead Sea Scrolls", "IMAX"]>]}
    #assert_equal expected, dmns.patrons_of_exhibits

  end





end
