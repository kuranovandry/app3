require 'rails_helper'

feature 'Categories page', js: true, type: :feature do
  # I am signed as a user
  given!(:authed_user) { create_logged_in_user }
  # Given there are two categories
  given!(:categories) { create_pair(:category) }
  # Given there is a category
  given(:category) { build :category }
  # When I visit the categories page
  before :each do
    visit categories_path
  end

  scenario 'Categories displaying' do
    expect(page).to have_content 'Categories list'
    # Then I should see 2 categories on the categories page
    within('.table') do
      expect(page).to have_content(categories.first.name)
      expect(page).to have_content(categories.last.name)
    end
  end

  scenario 'Category deleting' do
    # When I click on the destroy link for the first category
    with_confirm do
      within("tr#category-#{categories.first.id}") do
        click_link 'Destroy'
      end
    end
    # Then I should not see this category on the categories page
    expect(page).not_to have_content(categories.first.name)
  end

  scenario 'Category adding' do
    # When I click on the create my category link
    click_link 'Create my category'

    # And fill name field
    within('#new_category') do
      fill_in 'Name', with: category.name
    end

    # I should see new category on the categories page
    click_button 'Create Category'
    expect(page).to have_content(category.name)
  end
end
