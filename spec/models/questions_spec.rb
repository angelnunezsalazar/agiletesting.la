require 'nulldb_helper'
require './core/model/question'

describe Question do

    describe 'Update Averages' do
        it 'updates the averages the first time' do
            question=Question.new(
				average_current: 0,
				average_previous: 0,
				sum_all_answers: 0
            )
            
            question.update_averages(answer:5,respondents_number:1)

            expect(question.sum_all_answers).to eq(5)
            expect(question.average_previous).to eq(0)
            expect(question.average_current).to eq(5)
        end	

        it 'updates the averages the second time' do
            question=Question.new(
				average_current: 5,
				average_previous: 0,
				sum_all_answers: 5
            )
            
            question.update_averages(answer:3,respondents_number:2)

            expect(question.sum_all_answers).to eq(8)
            expect(question.average_previous).to eq(5)
            expect(question.average_current).to eq(4)
        end	

        it 'updates the averages with decimals' do
            question=Question.new(
				average_current: 4.5,
				average_previous: 0,
				sum_all_answers: 45
            )
            
            question.update_averages(answer:3,respondents_number:11)

            expect(question.sum_all_answers).to eq(48)
            expect(question.average_previous).to eq(4.5)
            expect(question.average_current.round(2)).to eq(4.36)
        end	        
    end
end