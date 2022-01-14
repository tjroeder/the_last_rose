require 'rails_helper'

RSpec.describe Outing, type: :model do
  let(:outing_1) { create(:outing) }

  describe 'relationships' do
    it { should have_many :contestant_outings }
    it { should have_many(:contestants).through(:contestant_outings) }
    it { should have_many(:bachelorettes).through(:contestants) }
  end

  describe 'validations' do
    it { validate_presence_of :name }
    it { validate_presence_of :location }
    it { validate_presence_of :date }
  end

  describe 'factory' do
    it 'creates valid contestant outing objects' do
      expect(outing_1).to be_a(Outing)
    end

    it 'creates valid attributes' do
      example = build(:outing, name: 'Food eating', location: 'hot dog shop', date: Date.new(2000,1,1))
      
      expect(example).to have_attributes(name: 'Food eating')
      expect(example).to have_attributes(location: 'hot dog shop')
      expect(example).to have_attributes(date: Date.new(2000,1,1))
    end
  end

  describe 'instance methods' do
    describe '#date_formatter' do
      it 'formats the outing date' do
        example = build(:outing, date: Date.new(2000, 8, 1))

        expect(example.date_formatter).to eq('08/01/2000')
      end
    end

    describe '#contestant_count' do
      it 'returns the count of the contestants on the outing' do
        cont_1 = create(:contestant)
        cont_2 = create(:contestant)
        cont_3 = create(:contestant)
        not_on_outing = create(:contestant)
        outing_1.contestants << cont_1
        outing_1.contestants << cont_2
        outing_1.contestants << cont_3

        expect(outing_1.contestant_count).to eq(3)
      end
    end
  end
end
