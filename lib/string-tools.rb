class StringTools
  # Change placeholder "%{placeholder}" to values in hash
  def self.replace_placeholder(string, hash)
    string.gsub(/%\{(\w+)\}/) { |match|
      hash[$1.to_sym]
    }
  end
end
