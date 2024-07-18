require_relative "lib/array-tools.rb"
require_relative "lib/calc-dist.rb"
require_relative "lib/data-analysis.rb"
require_relative "lib/json-tools.rb"

begin
  results = [
    "test/ci_mode_off/result_llama3_01.json",
    "test/ci_mode_off/result_llama3_01.json",
    "test/ci_mode_off/result_llama3_02.json",
    "test/ci_mode_off/result_llama3_03.json",
    "test/ci_mode_off/result_llama3_04.json",
  ]

  data = []
  results.each do |result|
    hash = JsonTools.json_to_hash result
    data.push(hash.map { |h| h["score"] })
  end

  DataAnalysis.hash_to_table data
end
