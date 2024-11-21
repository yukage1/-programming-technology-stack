require 'net/http'
require 'json'
require 'csv'

# Введіть ваш API-ключ та назву міста
api_key = '1447211beeec03c5344c62373d56a2cc'
city = 'Kyiv'
url = URI("http://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{api_key}&units=metric")

# Зробити запит до API
response = Net::HTTP.get_response(url)
if response.is_a?(Net::HTTPSuccess)
  data = JSON.parse(response.body)
else
  puts "Помилка запиту: #{response.code} - #{response.message}"
  exit
end

# Вивести повну відповідь для перевірки
puts "Отримана відповідь від API:"
puts JSON.pretty_generate(data)

# Витяг ключових даних
weather_info = [
  { label: 'Місто', value: city },
  { label: 'Температура (°C)', value: data.dig('main', 'temp') },
  { label: 'Вологість (%)', value: data.dig('main', 'humidity') },
  { label: 'Швидкість вітру (м/с)', value: data.dig('wind', 'speed') }
]

# Зберегти ключові дані у CSV файл у форматі "Параметр - Значення"
CSV.open('weather_data.csv', 'w') do |csv|
  weather_info.each do |info|
    csv << ["#{info[:label]} - #{info[:value]}"]
  end
end

puts "Ключові дані для міста #{city} збережено у файлі weather_data.csv у форматі 'Параметр - Значення'."
