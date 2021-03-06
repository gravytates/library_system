require "spec_helper"
require "rspec"
require "pg"
require "pry"

describe(Book) do
  describe ".all" do
    it('is empty at first') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe "#save" do
    it("adds a book to the array of saved books") do
      test_book = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => 1})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe "#title" do
    it("lets you give it a title") do
      test_book = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => 1})
      expect(test_book.title()).to(eq("The Hobbit"))
    end
  end

  describe "#id" do
    it("lets you read the author ID out") do
      test_book = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => 1})
      expect(test_book.id).to(eq(1))
    end
  end

  describe '#==' do
    it 'is the same book if it has the same description and list ID' do
      book1 = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => 1})
      book2 = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => 1})
      expect(book1).to(eq(book2))
    end
  end

  describe("#delete") do
    it("lets you delete a book from the database") do
      book = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => 1})
      book.save()
      book2 = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => 1})
      book2.save()
      book.delete()
      expect(Book.all()).to(eq([book2]))
    end
  end

  describe(".find") do
    it('returns book by id') do
      book1 = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => 1})
      book1.save()
      book2 = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => 1})
      book2.save()
      expect(Book.find(book1.id)).to(eq(book1))
    end
  end

  describe(".title_search") do
    it('returns book by id') do
      book1 = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => 1})
      book1.save()
      book2 = Book.new({:title => "The Lord of the Rings", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => 1})
      book2.save()
      expect(Book.title_search("The H")).to(eq([book1]))
    end
  end
end
