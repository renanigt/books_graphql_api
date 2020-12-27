require 'rails_helper'

module Mutations
  RSpec.describe CreateBook, type: :request do
    describe '#create_book' do
      context 'with title' do
        it 'creates a new book' do
          expect {
            post '/graphql', params: { query: query_with_title(title: "Book Test", description: "Description Test") }
          }.to change { Book.count }.by(1)
        end
      end

      context 'without title' do
        it 'does not creates a new book' do
          expect {
            post '/graphql', params: { query: query_without_title("Description Test") }
          }.not_to change { Book.count }
        end
      end
    end

    def query_with_title(title:, description:)
      <<~GQL
        mutation {
          createBook(
            title: "#{title}"
            description: "#{description}"
          ) {
            id
            title
          }
        }
      GQL
    end

    def query_without_title(description)
      <<~GQL
        mutation {
          createBook(
            description: "#{description}"
          ) {
            id
            title
          }
        }
      GQL
    end
  end
end
