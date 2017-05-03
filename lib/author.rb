class Author
  attr_reader(:name, :books, :book_id, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @books = attributes.fetch(:books)
    @book_id = attributes.fetch(:book_id)
    @id = attributes.fetch(:id)
  end

  def Author.all
   # @@all_authors
    returned_authors = DB.exec("SELECT * FROM author;")
    authors = []
    returned_authors.each() do |author|
      name = author.fetch('name')
      books = author.fetch('books')
      book_id = author.fetch('book_id').to_i
      id = author.fetch('id').to_i
      authors.push(Author.new({:name => name, :books => books, :book_id  => book_id, :id => id}))
    end
    authors
  end

  def save
   #  @@all_authors.push(self)
   result = DB.exec("INSERT INTO author (name, books, book_id) VALUES ('#{@name}', '#{@books}', #{@book_id}) RETURNING id;")
   @id = result.first.fetch('id').to_i
  end

  def ==(another_author)
    self.name.==(another_author.name).&(self.book_id.==(another_author.book_id))
  end

  define_singleton_method(:find) do |id|
    found_author = nil
    Author.all.each do |author|
      if author.id.==(id)
        found_author = author
      end
    end
    found_author
  end
end
