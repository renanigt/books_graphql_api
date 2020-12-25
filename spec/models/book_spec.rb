require 'rails_helper'

RSpec.describe Book, type: :model do
  describe '#valid' do
    it 'returns true with all attributes' do
      expect(Book.new(title: 'Title test', description: 'Description test')).to be_valid
    end

    it 'returns false without title' do
      expect(Book.new(description: 'Description test')).not_to be_valid
    end
  end
end
