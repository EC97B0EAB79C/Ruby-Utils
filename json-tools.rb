require "json"

class JsonTools
  def self.json_string_to_hash(json_string)
    json_string = json_string.gsub("'", '"').gsub("False", "false").gsub("True", "true").gsub("None", "null")
    ruby_hash = JSON.parse(json_string)
    ruby_hash
  end
end

begin
  test_string = ""
  test_hash = JsonTools.json_string_to_hash test_string

  test_hash.each do |hash|
    puts hash
  end
end
