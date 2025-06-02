

class Comment
  attr_accessor :id, :author, :content

  def initialize(id, author, content)
    @id = id
    @author = author
    @content = content

  end


  def create_comment()

    CSV.open("./db/comment.csv", "ab") do |csv|
      csv << [@id, @author, @content]
    end
  end


  def self.delete_all(id)

    table = CSV.read("./db/comment.csv")

    CSV.open("./db/comment.csv", "w") do |csv|
      table.each do |ligne|
        csv << ligne unless ligne[0].to_s == id.to_s
      end
    end
  end

  def self.all(id)
    all_comments = []

    CSV.foreach("./db/comment.csv") do |csv|
      if csv[0].to_s == id.to_s
      all_comments << Comment.new(csv[0], csv[1], csv[2])
      end
    end
    return all_comments
  end


end