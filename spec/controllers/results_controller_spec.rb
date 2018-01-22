require 'nulldb_helper'
require 'rack/test'
require './app'

describe 'Results Controller' do
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	it 'retorna el formulario de preguntas si el assessment previamente existe' do
		assessment=stub_model Assessment, :email => 'email@email.com', :completed => true
        allow(Assessment).to receive(:find_by).and_return(assessment)

		get "/assessment-results/#{assessment.id}-#{assessment.email}"
		expect(last_response.status).to eq(200)
	end

	it 'retorna 404 si no existe el assessment' do
		get "/assessment-results/1000-noexiste@email.com"
		expect(last_response.status).to eq(404)
	end

	it 'redirecciona a preguntas si aún no se completó el assessment' do
		assessment=stub_model Assessment, :email => 'email@email.com', :completed => false
		allow(Assessment).to receive(:find_by).and_return(assessment)
		
		get "/assessment-results/#{assessment.id}-email@email.com"
		expect(last_response).to be_redirect 
		follow_redirect!
		expect(last_request.path).to eq("/assessment-questions/#{assessment.id}-email@email.com")	
	end
end