require File.expand_path('../boot', __FILE__)

# Core manages the loading of the system.
#
# @note This file should not be edited directly. It is extended and
#   consumed via {Application} (./application.rb). All customizations
#   and overrides should be written in that class.
class Core
  ORM = ENV['DATABASE_ORM'].downcase.to_sym

  cattr_accessor :api
  self.api = File.expand_path('../api', __FILE__)

  cattr_accessor :db_dir
  self.db_dir = File.expand_path('../../db', __FILE__)

  cattr_accessor :config_dir
  self.config_dir = File.expand_path('../', __FILE__)

  cattr_accessor :orm_paths
  self.orm_paths = %w(relations commands mappers)

  cattr_accessor :load_paths
  self.load_paths = %w(models entities controllers)

  def self.connect!
    ROM.setup(Core::ORM, ENV['DATABASE_CONNECTION'])
    ROM.finalize
  end

  def self.load!
    ActiveSupport::Dependencies.autoload_paths += app_load_paths
    load_orm
    connect!
    require api
  end

  def self.load_orm
    orm_paths.each do |path|
      expanded_path = File.expand_path("../../app/#{path}", __FILE__)
      Dir["#{expanded_path}/**/*.rb"].each { |f| require f }
    end
  end

  def self.app_load_paths
    load_paths.collect { |l| "app/#{l}" }
  end
end
