require 'nulldb_helper'
Dir[File.join(File.dirname(__FILE__), '../../app/model', '*.rb')].each {|file| require file }
require './app/handlers/finish_assessment_handler'

describe 'Finish Assessment Handler' do

    let(:assessment) {stub_model Assessment}

    describe 'Assessment' do
        it 'complete the assessment' do
            assessment_id=1
            answers_param =[]
            stub_defaul_assessment(assessment_id)
            stub_default_assessmenttotals

            handler=FinishAssessmentHandler.new
            handler.execute(assessment_id,answers_param)
            
            expect(assessment.completed).to eq(true)
        end	
    end

    describe 'AssessmentTotals' do
        it 'increments the respondents number' do
            assessment_id=1
            answers_param =[]
            stub_defaul_assessment(assessment_id)
            assessment_totals=stub_model AssessmentTotals, :respondents_number => 1
            allow(AssessmentTotals).to receive_message_chain(:lock,:find).and_return(assessment_totals)

            handler=FinishAssessmentHandler.new
            handler.execute(assessment_id,answers_param)
            
            expect(assessment_totals.respondents_number).to eq(2)
        end	
    end
    
    describe 'Questions' do
        it 'updates the averages for all questions' do
            assessment_id=1
            answers_param = [{question: "Question1", answer: 5},
                             {question: "Question2", answer: 4}]
            stub_defaul_assessment(assessment_id)
            stub_respondents_number(respondents_number: 0)

            question1=stub_model(Question, :sum_all_answers => 0, :average_current => 0, :average_previous => 0)
            allow(Question).to receive_message_chain(:lock,:find_by).with(hash_including(:name => "Question1")).and_return(question1)
            question2=stub_model(Question, :sum_all_answers => 0, :average_current => 0, :average_previous => 0)
            allow(Question).to receive_message_chain(:lock,:find_by).with(hash_including(:name => "Question2")).and_return(question2)

            handler=FinishAssessmentHandler.new
            handler.execute(assessment_id,answers_param)

            expect(question1.sum_all_answers).to eq(5)
            expect(question1.average_previous).to eq(0)
            expect(question1.average_current).to eq(5)
            expect(question2.sum_all_answers).to eq(4)
            expect(question2.average_previous).to eq(0)
            expect(question2.average_current).to eq(4)
        end
    end

    def stub_defaul_assessment(assessment_id)
        allow(Assessment).to receive(:find).with(assessment_id).and_return(assessment)
    end

    def stub_default_assessmenttotals
        stub_respondents_number(respondents_number: 0)
    end

    def stub_respondents_number(respondents_number:)
        assessment_totals=stub_model AssessmentTotals, :respondents_number => respondents_number
        allow(AssessmentTotals).to receive_message_chain(:lock,:find).and_return(assessment_totals)
    end

end