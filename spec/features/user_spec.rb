require 'rails_helper'

feature 'the users page', js: true, type: :feature do
  given!(:user) { create(:user) }
  given!(:user_without_project) { create(:user) }
  given!(:project) { create(:project, user: user) }

  before :each do
    login_as(user, scope: 'user')
    visit users_path
  end

  context 'the filtering process', js: true, type: :feature do

    scenario 'user sees all users in index page' do
      within('.table') do
        expect(page).to have_content(user.email)
        expect(page).to have_text(user_without_project.email)
      end
    end

    scenario 'user sees all users with project' do
      select 'With project', from: 'filter'

      click_button 'Filter'

      within('.table') do
        expect(page).to have_text(user.email)
        expect(page).not_to have_text(user_without_project.email)
      end
    end

    scenario 'user sees all users without project' do
      select 'Without project', from: 'filter'

      click_button 'Filter'

      within('.table') do
        expect(page).to have_text(user_without_project.email)
        expect(page).not_to have_text(user.email)
      end
    end
  end

  context 'the user editing' do

    scenario 'user sees a message about successful update when everything is all right' do
      within "tr#user-#{user.id}" do
        click_link('Edit')
      end

      fill_in 'First name', with: 'Name'
      fill_in 'Last name', with: 'Surname'

      click_button 'Update'

      expect(page).to have_content 'User was successfully updated.'

      visit users_path

      within "tr#user-#{user.id}" do
        expect(page).to have_content 'Name Surname'
      end
    end

    scenario 'user sees a validation error when first name field blank' do
      visit edit_user_registration_path

      fill_in 'First name', with: ''

      click_button 'Update'
      expect(page).to have_content "First name can't be blank"
    end
  end
end
