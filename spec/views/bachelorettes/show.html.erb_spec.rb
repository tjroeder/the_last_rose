require 'rails_helper'

RSpec.describe 'bachelorette/:id/show.html.erb', type: :feature do
  let(:bach_1) { create(:bachelorette) }

  before(:each) { visit bach_path(bach_1) }

  context 'as a user' do
    describe 'view page elements' do
      it 'displays bachelorette information' do
        expect(page).to have_content(bach_1.name)
        expect(page).to have_content(bach_1.season_number)
        expect(page).to have_content(bach_1.desc)
      end

      it 'displays a link to the bachelorettes contestants' do
        expect(page).to have_link('Contestants', href: bach_cont_index_path(bach_1))
      end

      it 'displays the average age of contestants' do
        create_list(:contestant, 3, bachelorette: bach_1)
        visit bach_path(bach_1)
        
        expect(page).to have_content("Average Age of Contestants: #{bach_1.contestant_avg_age}")
      end
    end

    describe 'clickable elements' do
      it 'redirects to bachelorettes contestants index with contestants link' do
        expect(page).to have_current_path(bach_path(bach_1))

        click_link('Contestants')

        expect(page).to have_current_path(bach_cont_index_path(bach_1))
      end
    end
  end
end