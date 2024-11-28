require 'net/http'
require 'json'
require 'csv'

api_key = '1447211beeec03c5344c62373d56a2cc'
city = 'Kyiv'
url = URI("http://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{api_key}&units=metric")

response = Net::HTTP.get_response(url)
if response.is_a?(Net::HTTPSuccess)
  data = JSON.parse(response.body)
else
  puts "Request error: #{response.code} - #{response.message}"
  exit
end

puts "Received response from API:"
puts JSON.pretty_generate(data)

weather_info = [
  { label: 'City', value: city },
  { label: 'Тemperature (°C)', value: data.dig('main', 'temp') },
  { label: 'Humidity (%)', value: data.dig('main', 'humidity') },
  { label: 'Wind speed (м/с)', value: data.dig('wind', 'speed') }
]

CSV.open('weather_data.csv', 'w') do |csv|
  weather_info.each do |info|
    csv << ["#{info[:label]} - #{info[:value]}"]
  end
end

puts "Key data for the city #{city} saved to file weather_data.csv "
