require 'rails_helper'

RSpec.describe 'contestants/show.html.erb', type: :feature do
  let!(:bach_1) { create(:bachelorette) }
  let!(:cont_1) { create(:contestant, bachelorette: bach_1) }
  let!(:out_1) { create(:outing) }
  let!(:out_2) { create(:outing) }
  let!(:out_3) { create(:outing) }
  let!(:cont_out_1) { create(:contestant_outing, contestant: cont_1, outing: out_1) }
  let!(:cont_out_2) { create(:contestant_outing, contestant: cont_1, outing: out_2) }
  
  before(:each) { visit contestant_path(cont_1) }

  context 'as a user' do
    describe 'view page elements' do
      it 'displays the contestants info' do
        expect(page).to have_content(cont_1.name)
        expect(page).to have_content("Season #{bach_1.season_number}")
        expect(page).to have_content(bach_1.desc)
      end

      it 'displays the outings name' do
        expect(page).to have_content(out_1.name)
        expect(page).to have_content(out_2.name)
        expect(page).to have_no_content(out_3.name)
      end
    end

    describe 'clickable elements' do
      it 'outing names redirect the user to the outing show page' do
        expect(page).to have_current_path(contestant_path(cont_1))

        within("#outing-#{out_1.id}") do
          expect(page).to have_link(out_1.name, href: outing_path(out_1))
          click_link(out_1.name)
        end
        expect(page).to have_current_path(outing_path(out_1))
        
        visit contestant_path(cont_1)

        within("#outing-#{out_2.id}") do
          expect(page).to have_link(out_2.name, href: outing_path(out_2))
          click_link(out_2.name)
        end
        expect(page).to have_current_path(outing_path(out_2))
      end
    end
  end
end