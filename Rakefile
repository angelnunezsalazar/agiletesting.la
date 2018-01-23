require './app'
require 'sinatra/activerecord/rake'
require 'rake/tasklib'
require 'rake/sprocketstask'

namespace :assets do
  desc 'Precompile assets'
  task :precompile do
    environment = Sinatra::Application.assets
    manifest = Sprockets::Manifest.new(environment.index, File.join(Sinatra::Application.assets_path, "manifest.json"))
    manifest.compile(Sinatra::Application.assets_precompile)
  end

  desc "Clean assets"
  task :clean do
    FileUtils.rm_rf(Sinatra::Application.assets_path)
  end
end