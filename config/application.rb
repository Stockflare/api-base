require File.expand_path('../boot', __FILE__)

class Application

  cattr_accessor :api
  self.api = File.expand_path('../api', __FILE__)

  cattr_accessor :db_dir
  self.db_dir = File.expand_path('../../db', __FILE__)

  cattr_accessor :config_dir
  self.config_dir = File.expand_path('../', __FILE__)

  cattr_accessor :load_paths
  self.load_paths = %w{models entities controllers commands mappers relations}

  def self.connect!
    ROM.setup(:sql, ENV['DATABASE_CONNECTION'])
  end

  def self.load!
    self.connect!
    ActiveSupport::Dependencies.autoload_paths += app_load_paths
    require self.api
  end

  private

  def self.app_load_paths
    load_paths.collect { |l| "app/#{l}" }
  end

end
