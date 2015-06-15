require 'rails_helper'

describe 'the signup process', js: true, type: :feature do
  it 'signs me in' do
    visit new_user_registration_path

    within('#new_user') do
      fill_in 'First name', with: 'Andre'
      fill_in 'Last name', with: 'Andre'
      fill_in 'Date of birth', with: '10/10/2010'
      fill_in 'Email', with: 'mail@mail.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
    end

    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  it 'displays error when user does not fill first name' do
    visit new_user_registration_path

    within('#new_user') do
      fill_in 'First name', with: nil
      fill_in 'Last name', with: 'Andre'
      fill_in 'Date of birth', with: '10/10/2010'
      fill_in 'Email', with: 'mail@mail.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
    end

    click_button 'Sign up'

    expect(page).to have_content "First name can't be blank"
  end
end
