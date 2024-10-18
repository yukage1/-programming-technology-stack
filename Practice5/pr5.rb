require 'net/http'
require 'json'
require 'csv'

# Введіть ваш API-ключ та назву міста
api_key = '1447211beeec03c5344c62373d56a2cc'
city = 'Kyiv'
url = URI("http://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{api_key}&units=metric")

# Зробити запит до API
response = Net::HTTP.get(url)
data = JSON.parse(response)

# Вивести повну відповідь для перевірки
puts "Отримана відповідь від API:"
puts JSON.pretty_generate(data)

# Функція для розгортання вкладених елементів JSON у плоску структуру
def flatten_json(data, prefix = '')
  flat_hash = {}
  data.each do |key, value|
    if value.is_a?(Hash)
      flat_hash.merge!(flatten_json(value, "#{prefix}#{key}."))
    elsif value.is_a?(Array)
      value.each_with_index do |v, i|
        if v.is_a?(Hash)
          flat_hash.merge!(flatten_json(v, "#{prefix}#{key}[#{i}]."))
        else
          flat_hash["#{prefix}#{key}[#{i}]"] = v
        end
      end
    else
      flat_hash["#{prefix}#{key}"] = value
    end
  end
  flat_hash
end

# Розгорнути JSON у плоску структуру
flattened_data = flatten_json(data)

# Зберегти плоскі дані у CSV файл
CSV.open('weather_data_full.csv', 'w', write_headers: true, headers: flattened_data.keys) do |csv|
  csv << flattened_data.values
end

puts "Повна відповідь від API для міста #{city} збережена у файлі weather_data_full.csv"
