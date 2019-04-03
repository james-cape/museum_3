class Museum

  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.map do |exhibit|
      exhibit if patron.interests.include?(exhibit.name)
    end.compact
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    patrons_by_interest = {}
    @exhibits.each do |exhibit|
    patrons_by_interest[exhibit] = patrons.map { |patron| patron if patron.interests.include?(exhibit.name)}.compact
    end
    patrons_by_interest
  end


# For `patrons_by_exhibit_interest`, this method takes no arguments and returns a Hash where each key is an Exhibit. The value associated with that Exhibit is an Array of all the Patrons that have an interest in that exhibit.

end
