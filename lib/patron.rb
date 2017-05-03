class Patron
  attr_reader(:name, :book_history, :current_books, :due_date, :book_id, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @book_history = attributes.fetch(:book_history)
    @current_books = attributes.fetch(:current_books)
    @due_date = attributes.fetch(:due_date)
    @book_id = attributes.fetch(:book_id)
    @id = attributes.fetch(:id)
  end

  def Patron.all
   # @@all_patrons
    returned_patrons = DB.exec("SELECT * FROM patron;")
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch('name')
      book_history = patron.fetch('book_history')
      current_books = patron.fetch('current_books')
      due_date = patron.fetch('due_date')
      book_id = patron.fetch('book_id').to_i
      id = patron.fetch('id').to_i
      patrons.push(Patron.new({:name => name, :book_history => book_history, :current_books => current_books, :due_date => due_date, :book_id  => book_id, :id => id}))
    end
    patrons
  end

  def save
   #  @@all_patrons.push(self)
   result = DB.exec("INSERT INTO patron (name, book_history, current_books, due_date, book_id) VALUES ('#{@name}', '#{@book_history}','#{@current_books}','#{@due_date}', #{@book_id}) RETURNING id;")
   @id = result.first.fetch('id').to_i
  end

  def ==(another_patron)
    self.name.==(another_patron.name).&(self.book_id.==(another_patron.book_id))
  end

  define_singleton_method(:find) do |id|
    found_patron = nil
    Patron.all.each do |patron|
      if patron.id.==(id)
        found_patron = patron
      end
    end
    found_patron
  end

end
