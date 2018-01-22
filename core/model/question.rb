class Question < ActiveRecord::Base

    def update_averages (answer:,respondents_number:)
        self.sum_all_answers = self.sum_all_answers + answer
        self.average_previous = self.average_current
        self.average_current = (self.sum_all_answers)/(respondents_number)
    end
end