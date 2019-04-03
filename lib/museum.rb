class Museum

  attr_reader :name,
              :exhibits,
              :patrons,
              :revenue,
              :patrons_of_exhibits

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @revenue = 0
    @patrons_of_exhibits = {}
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    recommended = @exhibits.map do |exhibit|
      exhibit if patron.interests.include?(exhibit.name)
    end.compact

    recommended.sort_by do |exhib|
      exhib.cost
    end.reverse

  end

  def admit(patron)
    @patrons << patron
    patron_list = []
    recommend_exhibits(patron).each do |exhibit|
      if exhibit.cost <= patron.spending_money
        patron.spending_money -= exhibit.cost
        @revenue += exhibit.cost
        patron_list << patron
        patrons_of_exhibits[exhibit] = patron_list
      end
    end
  end



  def patrons_by_exhibit_interest
    patrons_by_interest = {}
    @exhibits.each do |exhibit|
    patrons_by_interest[exhibit] = patrons.map { |patron| patron if patron.interests.include?(exhibit.name)}.compact
    end
    patrons_by_interest
  end
end
