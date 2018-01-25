class CreateAssessmentDraftHandler
    def execute(email,country,company)
        assessment=Assessment.create(
            email: email,
            country: country,
            company: company,
            completed: false
        ) 
		return assessment      
    end
end