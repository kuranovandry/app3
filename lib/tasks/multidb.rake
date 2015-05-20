namespace :db do
  desc 'Migration of second database'
  task migrate_db2: :environment do
    ActiveRecord::Base.establish_connection "db2_#{Rails.env}"
    ActiveRecord::Migrator.migrate('db/migrate_db2/')
  end

  task rollback_db2: :environment do
    ActiveRecord::Base.establish_connection "db2_#{Rails.env}"
    ActiveRecord::Migrator.rollback('db/migrate_db2/')
  end
end
