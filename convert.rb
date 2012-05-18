## Eddy Kim
## convert.rb
## Converts KissMetrics JSON files into a single csv file


require 'json'
require 'date'
require 'csv'

if File.exists?("data.csv")
  puts 'Error: data.csv already exists, please rename or remove it'
else

puts 'Converting *.json files into data.csv...'

Dir.glob('./*.json') do |file|
  json = ""
  begin
    json = File.read(file)
    puts "Parsing [" + file + "]"
    json.split("\n").each do |data|
      temp = JSON.parse(data)
      CSV.open("data.csv", "a") do |csv|
        csv << [ temp['_n'], temp["_p"], DateTime.strptime(temp['_t'].to_s,'%s')]
      end
    end
  rescue
    puts "Error: Parsing [#{file}]"
  end
end
end