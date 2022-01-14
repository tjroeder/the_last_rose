require 'rails_helper'

RSpec.describe Bachelorette, type: :model do
  let(:bach_1) { build(:bachelorette) }

  describe 'relationships' do
    it { should have_many(:contestants) }
    it { should have_many(:contestant_outings).through(:contestants) }
    it { should have_many(:outings).through(:contestant_outings) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :season_number }
    it { should validate_presence_of :desc }
  end

  describe 'factory' do
    it 'creates valid bachelorette objects' do
      expect(bach_1).to be_a(Bachelorette)
    end

    it 'creates valid attributes' do
      example = build(:bachelorette, name: 'name_1', season_number: 1, desc: 'desc_1')

      expect(example).to have_attributes(name: 'name_1')
      expect(example).to have_attributes(season_number: 1)
      expect(example).to have_attributes(desc: 'desc_1')
    end
  end

  describe 'instance methods' do
    describe '#contestant_avg_age' do
      it 'returns the average age of the bachelorette contestants' do
        create(:contestant, bachelorette: bach_1, age: 1)
        create(:contestant, bachelorette: bach_1, age: 2)
        create(:contestant, bachelorette: bach_1, age: 3)
        create(:contestant, bachelorette: bach_1, age: 4)
        
        expect(bach_1.contestant_avg_age).to eq(2.5)
      end
      
      it 'returns 0 if there are no contestants' do
        expect(bach_1.contestant_avg_age).to eq(0)
      end
    end
    
    describe '#contestants_hometowns' do
      it 'returns a unique list of hometowns' do
        create(:contestant, bachelorette: bach_1, hometown: 'denver')
        create(:contestant, bachelorette: bach_1, hometown: 'denver')
        create(:contestant, bachelorette: bach_1, hometown: 'boulder')

        expect(bach_1.contestants_hometowns).to contain_exactly('denver', 'boulder')
      end
    end
  end
end
