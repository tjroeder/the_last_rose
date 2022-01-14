require 'rails_helper'

RSpec.describe 'outings/show.html.erb', type: :feature do
  let!(:bach_1) { create(:bachelorette) }
  let!(:bach_2) { create(:bachelorette) }
  let!(:cont_1) { create(:contestant, bachelorette: bach_1) }
  let!(:cont_2) { create(:contestant, bachelorette: bach_1) }
  let!(:cont_3) { create(:contestant, bachelorette: bach_2) }
  let!(:cont_4) { create(:contestant, bachelorette: bach_1) }
  let!(:out_1) { create(:outing) }
  let!(:out_2) { create(:outing) }
  let!(:cont_out_1) { create(:contestant_outing, contestant: cont_1, outing: out_1) }
  let!(:cont_out_2) { create(:contestant_outing, contestant: cont_2, outing: out_1) }
  let!(:cont_out_3) { create(:contestant_outing, contestant: cont_3, outing: out_2) }
  let!(:cont_out_4) { create(:contestant_outing, contestant: cont_4, outing: out_1) }
  
  before(:each) { visit outing_path(out_1) }

  context 'as a user' do
    describe 'view page elements' do
      it 'displays the outing name, location, and date' do
        expect(page).to have_content(out_1.name)
        expect(page).to have_content("Location: #{out_1.location}")
        expect(page).to have_content("Date: #{out_1.date_formatter}")
      end

      it 'displays count of outing contestants' do
        expect(page).to have_content("Count of Contestants: #{out_1.contestant_count}")
      end

      it 'displays a list of contestants' do
        expect(page).to have_content(cont_1.name)
        expect(page).to have_content(cont_2.name)
        expect(page).to have_no_content(cont_3.name)
        expect(page).to have_content(cont_4.name)
      end
    end
  end
end