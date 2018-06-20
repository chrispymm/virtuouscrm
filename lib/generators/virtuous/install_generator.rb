require 'rails/generators'
require 'rails/generators/migration'

module Virtuous
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)
    desc "Add the migrations for Virtuous"

    def self.next_migration_number(path)
      next_migration_number = current_migration_number(path) + 1
      ActiveRecord::Migration.next_migration_number(next_migration_number)
    end

    def copy_migrations
      migration_template "create_virtuous_access_tokens.rb", "db/migrate/create_virtuous_access_tokens.rb"
      say("Migration files copied.  Now run Rake db:migrate", :yellow)
    end

    def copy_initializer
      copy_file "default_config.rb", "config/initializers/virtuous.rb"
    end

  end
end
