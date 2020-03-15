require 'rails_helper'

RSpec.describe Post, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should have_many(:comments) }
  end
end

