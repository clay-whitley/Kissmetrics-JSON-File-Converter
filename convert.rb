## Originally by Eddy Kim, forked and updated to include properties and headers by Clay Whitley
## convert.rb
## Converts KissMetrics JSON files into a single csv file


require 'json'
require 'date'
require 'csv'
require 'pry'

if File.exists?("data.csv")
  puts 'Error: data.csv already exists, please rename or remove it'
else

puts 'Converting *.json files into data.csv...'

Dir.glob('./*.json') do |file|
  file_name = file.split('.')[1][1..-1]
  headers = ["Identity", "Timestamp", "Event"]
  property_names = []
  rows = []
  json = ""
  json = File.read(file)
  puts "Parsing [" + file + "]"
  json.split("\n").each do |data|
    temp = JSON.parse(data)
    temp.each do |key, val|
      unless key == "_n" || key == "_p" || key == "_p2" || key == "_t"
        unless headers.include?(key)
          headers << key
          property_names << key
        end
      end
    end
    rows << temp
  end

  processed_rows = []

  rows.each do |row|
    processed_row = []
    row.each do |key, val|
      processed_row[0] = val if key == "_p"
      processed_row[1] = val if key == "_t"
      processed_row[2] = val if key == "_n"
      (3..headers.length).each do |i|
        if key == headers[i]
          processed_row[i] = val
        else
          processed_row[i] = ""
        end
      end
      processed_rows << processed_row
    end
  end
  # CSV.open(file_name + ".csv", "a", write_headers: true, headers: headers) do |csv|
  #   csv << [ temp['_n'], temp["_p"], DateTime.strptime(temp['_t'].to_s,'%s')]
  # end
  binding.pry
end
end