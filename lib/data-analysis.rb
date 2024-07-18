class DataAnalysis
  def self.hash_to_table(data)
    parameters = data.first.first.keys
    parameters.each do |parameter|
      puts parameter

      # Prints table headers
      col_len = data.length
      header = "|"
      col_len.times do |i|
        header += "  #{i}  |"
      end
      puts header + "\n|" + " --- |" * col_len

      # Prints each row
      row_len = data.first.length
      row_len.times do |i|
        row = "|"
        col_len.times do |j|
          row += " #{data[j][i][parameter]} |"
        end
        puts row
      end
    end
  end
end
