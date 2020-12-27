module Mutations
  class CreateBook < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: false

    type Types::BookType

    def resolve(title: nil, description: nil)
      Book.create!(
        title: title,
        description: description
      )
    end
  end
end