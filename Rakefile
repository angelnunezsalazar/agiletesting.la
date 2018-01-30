require './app'
require 'sinatra/activerecord/rake'
require 'rake/tasklib'
require 'rake/sprocketstask'

task :log do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

namespace :assets do
  desc 'Precompile assets'
  task :precompile do
    FileUtils.rm_rf(Sinatra::Application.assets_path)
    environment = Sinatra::Application.assets
    manifest = Sprockets::Manifest.new(environment.index, File.join(Sinatra::Application.assets_path, Sinatra::Application.manifest))
    manifest.compile(Sinatra::Application.assets_precompile)
  end
end