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

  end
end
