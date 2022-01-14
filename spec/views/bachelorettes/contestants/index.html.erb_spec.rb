require 'rails_helper'

RSpec.describe 'bachelorette_contestants/index.html.erb', type: :feature do
  let!(:bach_1) { create(:bachelorette) }
  let!(:bach_2) { create(:bachelorette) }
  let!(:cont_1) { create(:contestant, bachelorette: bach_1, hometown: 'taco') }
  let!(:cont_2) { create(:contestant, bachelorette: bach_1, hometown: 'taco') }
  let!(:cont_3) { create(:contestant, bachelorette: bach_2) }
  let!(:cont_4) { create(:contestant, bachelorette: bach_1, hometown: 'hello') }
  
  before(:each) { visit bach_cont_index_path(bach_1) }

  context 'as a user' do
    describe 'view page elements' do
      it 'displays only the bachelorettes contestants' do
        not_contestant = create(:contestant)
        visit bach_cont_index_path(bach_1)

        expect(page).to have_content(cont_1.name)
        expect(page).to have_content(cont_2.name)
        expect(page).to have_no_content(not_contestant.name)
      end

      it 'displays the contestants info' do
        within("#cont-#{cont_1.id}") do
          expect(page).to have_content("Name: #{cont_1.name}")
          expect(page).to have_content("Age: #{cont_1.age}")
          expect(page).to have_content("Hometown: #{cont_1.hometown}")
        end

        within("#cont-#{cont_2.id}") do
          expect(page).to have_content("Name: #{cont_2.name}")
          expect(page).to have_content("Age: #{cont_2.age}")
          expect(page).to have_content("Hometown: #{cont_2.hometown}")
        end
      end

      it 'displays a unique list of contestants hometowns' do
        within("#contestant-list") do
          expect(page).to have_content(cont_1.hometown, maximum: 1)
          expect(page).to have_no_content(cont_3.hometown)
          expect(page).to have_content(cont_4.hometown)
        end
      end
    end
    
    describe 'clickable elements' do
      it 'displays a link that redirects to contestant show page' do
        expect(page).to have_current_path(bach_cont_index_path(bach_1))

        within("#cont-#{cont_1.id}") do
          expect(page).to have_link(cont_1.name, href: contestant_path(cont_1))
          click_link cont_1.name
        end
        expect(page).to have_current_path(contestant_path(cont_1))
        
        visit bach_cont_index_path(bach_1)
        expect(page).to have_current_path(bach_cont_index_path(bach_1))
        
        within("#cont-#{cont_2.id}") do
          expect(page).to have_link(cont_2.name, href: contestant_path(cont_2))
          click_link cont_2.name
        end
        expect(page).to have_current_path(contestant_path(cont_2))
      end
    end
  end
end