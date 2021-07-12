require 'rails_helper'

RSpec.describe Property, type: :model do
  subject { Property.new }

  describe 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :description }
    it { should validate_presence_of :is_for_rent }
    it { should validate_presence_of :monthly_price }
    it { should validate_numericality_of :monthly_price }

    describe 'associations' do
      it { should belong_to(:user) }
      it { should have_many(:favorites) }
    end

    it 'attaches default featured image' do
      @user = FactoryBot.create(:user)
      @property = Property.create!(
        name: Faker::Commerce.product_name,
        address: Faker::Address.street_address,
        monthly_price: rand(1.0..100.0),
        is_for_rent: true,
        description: Faker::Lorem.sentence(word_count: 3),
        user_id: @user.id
    )
      expect(@property.featured_image).to be_attached
    end
  end
end
