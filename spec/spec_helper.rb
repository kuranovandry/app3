require_relative 'support/controller_helpers'
require_relative 'support/request_helpers'
require 'devise'
require 'database_cleaner'

RSpec.configure do |config|
  config.include ControllerHelpers, type: :controller
  config.include RequestHelpers
  Warden.test_mode!

  config.after do
    Warden.test_reset!
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end


  config.before(:suite) do
    DatabaseCleaner[:active_record, connection: :test].clean_with(:truncation)
    DatabaseCleaner[:active_record, connection: :db2_test].clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner[:active_record, connection: :test].strategy = :transaction
    DatabaseCleaner[:active_record, connection: :db2_test].strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner[:active_record, connection: :test].start
    DatabaseCleaner[:active_record, connection: :db2_test].start
  end

  config.after(:each) do
    DatabaseCleaner[:active_record, connection: :test].clean
    DatabaseCleaner[:active_record, connection: :db2_test].clean
  end
end
