 require 'bundler'
 Bundler.require

 class Gossip
  attr_accessor :author, :content


  def initialize(author, content)
    @author = author
    @content = content

  end


  def save

    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end


  def self.all
    all_gossips = []

    CSV.read('./db/gossip.csv').each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end


  def self.find(id)

    all_gossips = self.all

    return all_gossips[id]
  end


  def update(id)

    lignes = CSV.read('./db/gossip.csv')
    lignes[id] = [@author, @content]

    CSV.open('./db/gossip.csv', 'w') do |csv|
      lignes.each {|ligne| csv << ligne}
    end
  end



end
