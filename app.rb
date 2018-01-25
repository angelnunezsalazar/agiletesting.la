require 'sinatra'
require "sinatra/content_for"
require 'sinatra/flash'
require 'sinatra/activerecord'
require 'json'
require './core/infrastructure/asset_pipeline'
require './config/environments'
Dir[File.join(File.dirname(__FILE__), 'core/model', '*.rb')].each {|file| require file }
Dir[File.join(File.dirname(__FILE__), 'core/handlers', '*.rb')].each {|file| require file }

set :public_folder, 'public'
set :views, File.dirname(__FILE__) + "/views"
enable :sessions
Tilt.register Tilt::ERBTemplate, 'html'
register AssetPipeline

get '/' do
	redirect '/assessment'
end

get '/assessment' do
	erb :'assessment-home'
end

post '/assessment-start' do
	create_assessment_draft=CreateAssessmentDraftHandler.new
	assessment=create_assessment_draft.execute(params[:email],params[:country],params[:company])
	redirect "/assessment-questions/#{assessment.id}-#{assessment.email}"
end

get '/assessment-questions/:assessment_id-:assessment_email' do
	assessment=Assessment.find_by(id: params[:assessment_id], email:params[:assessment_email])
	halt 404 unless assessment.present?
	redirect "/assessment-results/#{assessment.id}" unless assessment.completed == false
	@questions_whole_team = Question.where(pillar: 1)
	@questions_automation = Question.where(pillar: 2)
	@questions_testing = Question.where(pillar: 3)
	@assessment_id= params[:assessment_id]
	erb :'assessment-questions'
end

post '/assessment-finish' do
	Assessment.transaction do
		assessment_id = params[:assessment_id]
		answers_param = params[:answers].map do |question_id,question_value|
			question_value
		end
		finish_assessment_handler=FinishAssessmentHandler.new
		assessment=finish_assessment_handler.execute(assessment_id,answers_param)
		redirect "/assessment-results/#{assessment.id}-#{assessment.email}"
	end
end

get '/assessment-results/:assessment_id-:assessment_email' do
	assessment=Assessment.find_by(id: params[:assessment_id], email: params[:assessment_email])
	halt 404 unless assessment.present?
	redirect "/assessment-questions/#{assessment.id}-#{assessment.email}" unless assessment.completed?
	@assessment_id=params[:assessment_id]
	erb :'assessment-results'
end

get '/api/assessment/:assessment_id/answers' do
	answers = Answer.where(assessment_id: params[:assessment_id],pillar: params[:pillar])
	return answers.to_json;
end

get '/api/questions' do
	questions = Question.where(pillar: params[:pillar])
	return questions.to_json;
end

post '/api/assessment' do
	payload = JSON.parse(request.body.read)
	Assessment.transaction do
		create_assessment_draft=CreateAssessmentDraftHandler.new
		assessment=create_assessment_draft.execute(payload[:email],payload[:country],payload[:company])
		finish_assessment=FinishAssessmentHandler.new
		assessment=finish_assessment.execute(assessment.id,payload[:answers])		
	end
	return { :message => "Assessment Created",
			 :assessment => assessment }.to_json
end