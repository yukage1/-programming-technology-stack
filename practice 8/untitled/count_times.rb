require 'find'

def count_items_in_directory(directory_path)
  raise ArgumentError, 'Директорії не існує' unless Dir.exist?(directory_path)

  files_count = 0
  directories_count = 0 #Якщо потрібно виключити зовнішню папку момжна встановити на -1, тоді буде лише те що всередині

  Find.find(directory_path) do |path|
    if File.file?(path)
      files_count += 1
    elsif File.directory?(path)
      directories_count += 1
    end
  end

  { files: files_count, directories: directories_count }
end

if ARGV.empty?
  puts "Використовуйте: ruby count_items.rb <directory_path>"
else
  directory_path = ARGV[0]
  begin
    result = count_items_in_directory(directory_path)
    puts "Файлів: #{result[:files]}"
    puts "Папок: #{result[:directories]}"
  rescue ArgumentError => e
    puts e.message
  end
end