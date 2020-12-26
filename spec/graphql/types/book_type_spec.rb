require 'rails_helper'

module Types
  RSpec.describe BookType, type: :request do
    let!(:books) { create_list(:book, 3) }

    describe '#all_books' do
      it 'returns all books' do
        post '/graphql', params: { query: all_books_query }
        json_response = JSON.parse(response.body)
        
        expect(json_response["data"]["allBooks"]).to eq(books.map { |b| convert_to_hash(b) })
      end
    end

    describe '#search_books' do
      let!(:book_11) { create(:book, title: 'ABC 11', description: 'The Book 11') }
      let!(:book_15) { create(:book, title: 'ABC 15', description: 'The Book 15') }

      it 'returns list of books contains part of the title' do
        post '/graphql', params: { query: search_books_query("ABC 1") }
        json_response = JSON.parse(response.body)

        expect(json_response["data"]["searchBooks"]).to include(convert_to_hash(book_11))
        expect(json_response["data"]["searchBooks"]).to include(convert_to_hash(book_15))
      end
    end

    def convert_to_hash(book)
      book.attributes.except("id", "created_at", "updated_at")
    end

    def all_books_query
      <<~GQL
        {
          allBooks {
            title
            description
          }
        }
      GQL
    end

    def search_books_query(title)
      <<~GQL
        {
          searchBooks(title: "#{title}") {
            title
            description
          }
        }
      GQL
    end
  end
end
