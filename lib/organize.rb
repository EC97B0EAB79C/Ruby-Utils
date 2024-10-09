class Tango
  attr_accessor :hiragana, :kanji, :imi

  def initialize(kanji, hiragana, imi)
    @kanji = kanji
    @hiragana = hiragana
    @imi = imi
  end

  def to_s
    "#{@kanji}(#{@hiragana}): #{@imi}"
  end

  def to_r
    "| #{@kanji} | #{@hiragana} | #{@imi} |"
  end
end

def sort_by_hiragana(objects)
  objects.sort_by { |obj| obj.hiragana }
end

@section = ["あ","か","さ","た","な","ま","や","ら","わ"]

def read_markdown_table(file_path)
  table_data = []
  inside_table = false

  File.foreach(file_path) do |line|
    if line.include? "---"
      next
    end
    if line.include? "| 漢字 "
      next
    end

    if line.strip.start_with?('|')
      inside_table = true
      # Split the line by '|' and clean up whitespace
      row = line.split('|').map(&:strip).reject(&:empty?)
      table_data << Tango.new(*row) unless row.empty?
    end
  end

  @section.each do |s|
    table_data << Tango.new("section", s,"section")
  end

  table_data
end

# Example usage
file_path = 'Tango.md'
table_data = read_markdown_table(file_path)
table_data = sort_by_hiragana(table_data)
table_data.each do |row|
  if row.kanji == "section"
    puts "\n\n## #{row.hiragana}"
    puts "| 漢字 | ふりがな   | 意味      |"
    puts "| ---- | ---------- | --------- |"
    next
  end
  puts row.to_r
end
