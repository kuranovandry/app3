require 'csv'

desc 'Imports a CSV file'
namespace :import do
  task csv: :environment do
    CSV.foreach('db/users.csv', headers: true) do |row|
      User.create!(row.to_hash)
    end
  end
end
