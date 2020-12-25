module Types
  class QueryType < Types::BaseObject
    field :all_books, [BookType], null: false
    field :search_books, [BookType], null: false do
      argument :title, String, required: true
    end

    def all_books
      Book.all
    end

    def search_books(title:)
      Book.where('title like ?', "%#{title}%")
    end
  end
end
