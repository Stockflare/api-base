require File.expand_path('../config/environment', __FILE__)
require 'dotenv/tasks'

require 'rom/sql/rake_task'

namespace :db do
  task :setup do
    Application.connect!
  end
end
