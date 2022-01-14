require 'rails_helper'

RSpec.describe ContestantOuting, type: :model do
  let(:cont_out_1) { create(:contestant_outing) }
  
  describe 'relationships' do
    it { should belong_to(:contestant) }
    it { should belong_to(:outing) }
  end

  describe 'factory' do
    it 'creates valid contestant outing objects' do
      expect(cont_out_1).to be_a(ContestantOuting)
    end

    it 'creates valid attributes' do
      outing = build(:outing)
      contestant = build(:contestant)
      example = build(:contestant_outing, outing: outing, contestant: contestant)

      expect(example).to have_attributes(contestant: contestant)
      expect(example).to have_attributes(outing: outing)
    end
  end
end
