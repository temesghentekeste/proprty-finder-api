require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new }

  describe 'validations' do
    it 'should validate presence of username' do
      expect(subject.valid?).to be false
    end

    it { should validate_presence_of :username }
    it { should validate_presence_of :password }

    describe 'associations' do
      it { should have_many(:properties) }
      it { should have_many(:favorites) }
    end
  end
end
