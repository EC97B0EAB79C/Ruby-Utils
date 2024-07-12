require "json"
require "csv"

class JsonTools
  def self.json_string_to_hash(json_string)
    json_string = json_string.gsub("'", '"').gsub("False", "false").gsub("True", "true").gsub("None", "null")
    json_hash = JSON.parse json_string 
    json_hash
  end
  
  def self.json_to_csv(json_file_name, csv_file_name)
    json_file = File.read json_file_name
    json_hash = JSON.parse json_file
    
    CSV.open(csv_file_name, "w") do |csv|
      headers = json_hash.first.keys
      csv << headers

      json_hash.each do |hash|
        csv << hash.values_at(*headers)
      end
    end
  end
end

begin
  JsonTools.json_to_csv("test.json", "test.csv")
end
