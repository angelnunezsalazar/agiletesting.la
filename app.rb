require 'sinatra'
require "sinatra/content_for"
require 'sinatra/flash'

require 'json'

set :public_folder, 'public'
set :views, File.dirname(__FILE__) + "/views"
enable :sessions

get '/' do
	redirect '/assessment'
end

get '/assessment' do
	erb :"assessment"
end