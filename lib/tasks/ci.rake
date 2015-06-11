require 'rake'
require 'brakeman'
require 'bundler/audit/cli'
task :brakeman do
  report = Brakeman.run(app_path: '.', print_report: true)
  abort if report.filtered_warnings.present?
end

namespace :bundle do
  task :audit do
    %w(update check).each do |command|
      Bundler::Audit::CLI.start [command]
    end
  end
end

task :rubocop do
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
end

task :ci do
  tasks = []
  tasks << 'brakeman'
  tasks << 'bundle:audit'
  tasks << 'rubocop'

  tasks.each do |task|
    Rake::Task[task].invoke
  end
end
