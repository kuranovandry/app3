require 'rails_helper'

feature 'projects page', js: true, type: :feature do
  # given a user and signed
  given!(:user) { create_logged_in_user }

  # given a project
  given!(:project) { create(:project, user: user) }

  # given there are project with another user id
  given!(:another_project) { create(:project) }

  # I visit projects page
  before :each do
    visit projects_path
  end

  scenario 'Projects displaying' do
    # then I should see 2 projects
    within('.table') do
      expect(page).to have_content(project.name)
      expect(page).to have_content(another_project.name)
    end
  end

  scenario 'user create project' do
    # when I click on the create my project link
    click_link('Create my project')

    # and I fill in all fields
    within '.new_project' do
      fill_in 'Name', with: 'Test name'
      fill_in 'Description', with: 'Test description'
      fill_in 'Start date', with: '10/10/2015'
      fill_in 'End date', with: '11/11/2015'
    end

    # then I should see the flash message
    click_button('Create Project')
    expect(page).to have_content 'Project was successfully created.'

    # and I should see created project on the index page
    within '.table' do
      expect(page).to have_content 'Test name'
    end
  end

  scenario 'user sees validation error' do
    # when I click on the create my project link
    click_link('Create my project')

    # and I do not fill the field Name
    within '.new_project' do
      fill_in 'Name', with: ''
      fill_in 'Description', with: 'Test description'
      fill_in 'Start date', with: '10/10/2015'
      fill_in 'End date', with: '11/11/2015'
    end

    # then I should see validation error
    click_button('Create Project')
    expect(page).to have_content "Name can't be blank"
  end

  scenario 'existing project editing' do
    # when I click on the edit link
    within "tr#project-#{project.id}" do
      click_link('Edit')
    end

    # and update the field Name
    fill_in 'Name', with: 'Test Name'

    # then I should see the flash message
    click_button 'Update'
    expect(page).to have_content 'Project was successfully updated.'

    # and I must see new name on index page
    within "tr#project-#{project.id}" do
      expect(page).to have_content 'Test Name'
    end
  end

  scenario 'user sees validation error' do
    # when I click on the edit link
    within "tr#project-#{project.id}" do
      click_link('Edit')
    end

    # and I do not fill the field Name
    fill_in 'Name', with: ''
    click_button 'Update'

    # then I should see validation error
    expect(page).to have_content "Name can't be blank"
  end

  scenario 'user can not see edit button' do
    # then I must don't see edit link if project not my
    within "tr#project-#{another_project.id}"  do
      expect(page).to_not have_content 'Edit'
    end
  end

  scenario 'user deleting project' do
    # when i not project admin i can't see destroy link
    within "tr#project-#{another_project.id}"  do
      expect(page).to_not have_content 'Destroy'
    end

    # when I click on the destroy link of my project
    within "tr#project-#{project.id}" do
      click_link('Destroy')
    end

    # then I should see the flash message
    expect(page).to have_content 'Project was successfully destroyed.'

    # and not see this project
    within '.table' do
      expect(page).not_to have_content(project.name)
    end
  end
end
