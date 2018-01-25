require 'nulldb_helper'
require 'rack/test'
require './app'

describe 'Finish Controller' do
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	it 'redirecciona a los resultados si el assessment se proceso correctamente' do
        assessment=stub_model Assessment, :email => 'email@email.com'
        allow_any_instance_of(FinishAssessmentHandler).to receive(:execute).and_return(assessment)

        post "/assessment-finish", 
            :assessment_id => 1,
            :answers => []

        expect(last_response).to be_redirect 
        follow_redirect!
        expect(last_request.path).to eq("/assessment-results/#{assessment.id}-email@email.com")
	end
end