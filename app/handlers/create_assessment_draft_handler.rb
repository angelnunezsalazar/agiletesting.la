class CreateAssessmentDraftHandler
    def execute(email,country,company,industry)
        assessment=Assessment.create(
            email: email,
            country: country,
            company: company,
            industry: industry,
            completed: false
        ) 
		return assessment      
    end
end