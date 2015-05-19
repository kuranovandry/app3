require 'rails_helper'

feature 'Movies page', js: true, type: :feature do
  # I am signed as a user
  given!(:authed_user) { create_logged_in_user }

  # Given there are 2 movies for signed in user
  given!(:movies) { create_list(:movie, 2, user: authed_user) }

  # Given there is a 1 specific movie
  given!(:movie){ build :movie }

  # Given there is a 1 photo for specific movie
  given!(:photo) { create :upload, movie: movies.first }

  # Given there is a last photo
  given(:last_photo) { Upload.last }

  # Given there is a path for image uploading
  given(:test_image_path) { File.absolute_path('./spec/fixtures/images/test_image.jpeg') }

  # When I visit movies page
  before :each do
    visit movies_path()
  end

  scenario 'Movies displaying' do
    expect(page).to have_content 'Listing of movies'
    # Then I should see 2 movies on the movies page
    within('.table') do
      expect(page).to have_content(movies.first.name)
      expect(page).to have_content(movies.last.name)
    end
  end

  scenario 'Movie deleting' do

    # When I click on the destroy link for the first movie
    with_confirm do
      within("tr#movie-#{movies.first.id}") do
        click_link 'Destroy'
      end
    end
    # Then I should not see this movie on movies page
    expect(page).not_to have_content(movies.first.name)
  end

  scenario 'Movie updating' do

    # When I click on the edit link for the first movie
    within("tr#movie-#{movies.first.id}") do
      click_link 'Edit'
    end

    # And I fill all fields
    within("#edit_movie_#{movies.first.id}") do
      fulfill_movies_form
    end

    click_button 'Update Movie'

    # Then I should see updated movie on the movies page
    expect(page).to have_content(movie.name)
  end

  scenario 'Movie creating' do

    # When I click on the create my movie link for the first movie
    click_link 'Create my movie'

    # And I fill all fields
    within('#new_movie') do
      fulfill_movies_form
    end

    # Then I should see created movie on the movies page
    click_button 'Create Movie'
    expect(page).to have_content( movie.name )
  end

  scenario "Displaying movie's image" do
    # When I click on the gallery link for the first movie
    within("tr#movie-#{movies.first.id}") do
      click_link 'Gallery'
    end

    # Then I should see attached photo
    expect(page).to have_selector("img[src$='#{photo.file.url}']")
  end

  scenario "Movie's Photo attaching" do
    # When I click on the gallery link for the first movie
    within("tr#movie-#{movies.first.id}") do
      click_link 'Gallery'
    end

    # And I choose photo
    page.find('#fileupload').set(test_image_path)

    # Then I should see uploaded photo
    expect(page).to have_selector("img[src$='#{last_photo.file.url}']")
  end
end

def fulfill_movies_form
  fill_in 'Name', with: movie.name

  within_frame('movie_description_ifr') do
    editor = page.find_by_id('tinymce')
    editor.set movie.description
  end
  fill_in 'Release date', with: movie.release_date
end
