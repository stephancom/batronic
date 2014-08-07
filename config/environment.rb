require 'active_record'
require 'yaml'
require 'sqlite3'

DATABASE_ENV = ENV['DATABASE_ENV'] || 'development'
database_config = YAML.load_file('config/databases.yml')[DATABASE_ENV]
ActiveRecord::Base.establish_connection(database_config)