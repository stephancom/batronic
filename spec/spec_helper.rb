ENV["RAILS_ENV"] = 'test'
ENV["DATABASE_ENV"] = 'test'
require 'rspec'
require 'database_cleaner'
require 'factory_girl'
require 'factories'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.start
      FactoryGirl.lint
  end

  config.after(:suite) do
    DatabaseCleaner.clean
  end
end

