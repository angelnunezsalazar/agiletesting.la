class FinishAssessmentHandler
    def execute(assessment_id,answers_param)
        assessment=Assessment.find(assessment_id)
		assessment.completed= true

		assessment_totals=AssessmentTotals.lock.find(1)
		assessment_totals.respondents_number= assessment_totals.respondents_number + 1

		answers= []
		questions= []
		answers_param.each do |ap|
			question=Question.lock.find_by(name: ap[:question])
			answer=Answer.new(
				pillar: question.pillar,
				question_id: question.id,
				assessment_id: assessment_id,
				answer: ap[:answer]
				)
			question.update_averages(answer: answer.answer,respondents_number: assessment_totals.respondents_number)
			answers << answer
			questions << question			
		end

		assessment_totals.save!
		assessment.save!
		answers.each(&:save!)
		questions.each(&:save!)  
		return assessment      
    end
end