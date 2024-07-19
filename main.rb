require_relative "lib/array-tools.rb"
require_relative "lib/calc-dist.rb"
require_relative "lib/data-analysis.rb"
require_relative "lib/json-tools.rb"

begin
  llms = [
    "tinyllama:latest",
    "phi3:3.8b",
    "llama2:latest",
    "llama3:latest",
    "gemma2:latest",
  ]

  llms.each do |llm|
    puts "##### #{llm}"

    results = 30.times.map { |i| format("test/llms/result_#{llm}_%02d.json", i) }

    data = []
    results.each do |result|
      hash = JsonTools.json_to_hash result
      data.push(hash.map { |h| h["score"] })
    end

    DataAnalysis.hash_to_statistic data
  end

  #   results = 30.times.map { |i| format("test/llms/result_gemma2:latest_%02d.json", i) }
  #   puts results
end
