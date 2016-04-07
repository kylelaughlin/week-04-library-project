require "rake/testtask"
require "sinatra/activerecord"
require "sinatra/activerecord/rake"

task :default => :test
Rake::TestTask.new(:test) do |t|
  t.libs = %w(lib tests)
  t.pattern = "tests/**/*_test.rb"
end
task :default => :test

namespace :db do
  task :load_config do
    require_relative "./main.rb"
  end
end
