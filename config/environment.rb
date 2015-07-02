ENV['RACK_ENV'] ||= 'development'

spec = "environments/#{ENV['RACK_ENV']}.rb"
require spec if File.exists? spec

Dir["initializers/**/*.rb"].each { |f| require f }

require File.expand_path('../application', __FILE__)
