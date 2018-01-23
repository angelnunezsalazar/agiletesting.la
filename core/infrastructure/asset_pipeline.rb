require 'sprockets-helpers'
require 'uglifier'
require 'yui/compressor'

module AssetPipeline extend self
  def registered(app)
    app.set :assets, assets = Sprockets::Environment.new(app.settings.root)
    app.set :assets_path, -> { File.join(public_folder, "assets") }
    app.set :assets_precompile, %w(*.js *.css)
    app.set :manifest, "manifest-7f5cb74af5d7f4b82200738fdbdc5a45.json"
    assets.gzip = false

    # assets.append_path('assets/fonts')
    assets.append_path('assets/javascripts')
    assets.append_path('assets/stylesheets')
    # assets.append_path('assets/images')
    # assets.append_path('vendor/assets/javascripts')

    app.configure :development do
      assets.cache = Sprockets::Cache::FileStore.new('./tmp')
      app.get '/assets/*' do
        env['PATH_INFO'].sub!(%r{^/assets}, '')
        settings.assets.call(env)
      end
    end

    app.configure :production do
      assets.js_compressor  = Uglifier.new(mangle: true)
      assets.css_compressor = YUI::CssCompressor.new
      app.use Rack::Deflater
    end

    Sprockets::Helpers.configure do |config|
      config.environment = assets
      config.prefix      = '/assets'
      config.debug       = true if app.development?
      if app.production?
        config.digest      = true
        config.manifest    = Sprockets::Manifest.new(assets, File.join(app.assets_path, app.manifest))
      end
    end

    app.helpers Sprockets::Helpers
  end
end