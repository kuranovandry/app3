require 'rails_helper'

describe 'the signin process', js: true, type: :feature do
  let!(:user) { create(:user, password: '12345678') }

  it 'signs me in' do
    visit new_user_session_path

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '12345678'
    end

    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully'
  end
end
