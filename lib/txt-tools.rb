
class TxtTools
    def self.txt_to_string(txt_file_name)
        File.read txt_file_name
    end

    def self.string_to_txt(string, txt_file_name)
        File.open(txt_file_name, 'w+'){
            |file| file.write(string)
        }
    end
end