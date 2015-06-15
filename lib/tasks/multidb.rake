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

  namespace :schema do
    # desc 'Dump additional database schema'
    task dump: %i(environment load_config) do
      filename = "#{Rails.root}/db/db2_schema.rb"
      File.open(filename, 'w:utf-8') do |file|
        ActiveRecord::Base.establish_connection("db2_#{Rails.env}")
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end
  end

  namespace :test do
    task :load_schema do
      # like db:test:purge
      configuration = ActiveRecord::Base.configurations
      ActiveRecord::Base.connection.recreate_database(configuration['db2_test']['database'])
      # like db:test:load_schema
      ActiveRecord::Base.establish_connection('db2_test')
      ActiveRecord::Schema.verbose = false
      load("#{Rails.root}/db/db2_schema.rb")
    end
  end
end
