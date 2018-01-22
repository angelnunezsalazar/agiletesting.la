class FinishAssessmentHandler
    def handle(assessment_id,answers_param)
        assessment=Assessment.find(assessment_id)
		assessment.completed= true

		assessment_totals=AssessmentTotals.lock.find(1)
		assessment_totals.respondents_number= assessment_totals.respondents_number + 1

		answers= []
		questions= []
		answers_param.each do |ap|
			answer=Answer.new(
				pillar: ap[:pillar],
				question_id: ap[:question],
				assessment_id: assessment_id,
				answer: ap[:answer]
			)
			answers << answer
			question=Question.lock.find(ap[:question])
			question.update_averages(answer: answer.answer,respondents_number: assessment_totals.respondents_number)
			questions << question			
		end

		assessment_totals.save!
		assessment.save!
		answers.each(&:save!)
		questions.each(&:save!)  
		return assessment      
    end
end