
require 'httparty'

def load_assessment(assessment_json)
    @result = HTTParty.post("http://localhost:9292/api/assessment", 
        :body => assessment_json,
        :headers => { 'Content-Type' => 'application/json' })
    return @result
end

Dir.glob('./*.json') do |json_file|
    puts "Reading #{json_file} file"
    assessment_json = File.read(json_file)
    puts "Uploading Assessment"
    puts assessment_json
    result=load_assessment(assessment_json)
    puts "Successfull #{result}"
end