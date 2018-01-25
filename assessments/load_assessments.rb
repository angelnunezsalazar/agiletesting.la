
require 'httparty'

Dir.glob('./*.json') do |json_file|
    assessment_json = File.read(json_file)
    load_assessment(assessment_json)
end

def load_assessment ()
    @result = HTTParty.post(@urlstring_to_post.to_str, 
        :body => {:email => 'This is the screen name', 
                 :country => 'Application Problem', 
                 :company => 'Open', 
                 :answers => {
                    :answers => 'Normal',
                 }
                }.to_json,
        :headers => { 'Content-Type' => 'application/json' })
    put @result
end