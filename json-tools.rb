require "json"
require "csv"

class JsonTools
  def self.json_string_to_hash(json_string)
    json_string = json_string.gsub("'", '"').gsub("False", "false").gsub("True", "true").gsub("None", "null")
    json_hash = JSON.parse json_string 
    json_hash
  end
  
  def self.json_to_csv(json_file_name, csv_file_name, expand_key = [])
    json_file = File.read json_file_name
    json_hash = JSON.parse json_file
    
    CSV.open(csv_file_name, "w") do |csv|
      headers = json_expand_key(json_hash, expand_key)
      csv << headers

      json_hash.each do |hash|
        csv << hash_expand_to_list(hash, expand_key)
      end
    end
  end

  def self.json_expand_key(json_hash, expand_key)
    base_keys = json_hash.first.keys - expand_key
    base_keys + expand_key.flat_map { |key| json_hash.first[key].keys }
  end

  def self.hash_expand_to_list(hash, expand_key)
    base_keys = hash.keys - expand_key 
    base_list = hash.values_at(*base_keys)

    base_list + expand_key.flat_map { |key| hash[key].values_at(*hash[key].keys)}
  end
end

begin
  JsonTools.json_to_csv("test/test.json", "test/test.csv", ["Test"])
end
