
require 'httparty'

def load_assessment(assessment_json)
    url = "http://agiletesting.la/api/assessment"
    #url = "http://localhost:9292/api/assessment"
    @result = HTTParty.post(url, 
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