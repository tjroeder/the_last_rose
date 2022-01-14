require 'rails_helper'

RSpec.describe Contestant, type: :model do
  let(:cont_1) { build(:contestant) }

  describe 'relationships' do
    it { should belong_to :bachelorette }
    it { should have_many :contestant_outings }
    it { should have_many(:outings).through(:contestant_outings) }
  end

  describe 'validations' do
    it { validate_presence_of :name }
    it { validate_presence_of :age }
    it { validate_presence_of :hometown }
  end

  describe 'factory' do
    it 'creates valid contestant objects' do
      expect(cont_1).to be_a(Contestant)
    end

    it 'creates valid attributes' do
      bach = build(:bachelorette)
      example = build(:contestant, bachelorette: bach, name: 'Joe', age: 12, hometown: 'Anchorage')
      
      expect(example).to have_attributes(bachelorette: bach)
      expect(example).to have_attributes(name: 'Joe')
      expect(example).to have_attributes(age: 12)
      expect(example).to have_attributes(hometown: 'Anchorage')
    end
  end
end
