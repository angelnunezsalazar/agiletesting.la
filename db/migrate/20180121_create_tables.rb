class CreateTables < ActiveRecord::Migration[5.1]
	def change
		create_table "questions", :force => true do |t|
			t.string  "name"
			t.string  "description"
			t.integer "pillar"
			t.decimal "average_current", :default => 0
			t.decimal "average_previous", :default => 0
			t.decimal "sum_all_answers", :default => 0
		end

		create_table "assessments", :force => true do |t|
			t.string "email"
			t.string "industry"
			t.string "company"
			t.string "country"
			t.boolean "completed"
		end

		create_table "answers", :force => true do |t|
			t.decimal "answer"
			t.integer "pillar"
			t.references :assessment, foreign_key: true
			t.references :question, foreign_key: true
		end

		create_table "assessment_totals", :force => true do |t|
			t.integer "respondents_number"
		end


	end
end
