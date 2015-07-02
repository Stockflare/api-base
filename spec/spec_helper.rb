require File.expand_path('../../config/environment', __FILE__)

require 'airborne'
require 'database_cleaner'
require 'factory_girl'
require 'grape-entity-matchers'

Application.load!

Airborne.configure do |config|
  config.rack_app = API
end

Dir["#{File.expand_path('../', __FILE__)}/factories/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
