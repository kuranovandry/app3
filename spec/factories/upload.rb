include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :upload, class: 'Upload' do
    file { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'test_image.jpeg'), 'image/jpeg') }
    movie
  end
end
