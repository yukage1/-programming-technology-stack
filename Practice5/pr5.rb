require 'uri'
require 'net/http'
require 'openssl'

url = URI(" https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Paris?key=<1447211beeec03c5344c62373d56a2cc>")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)

response = http.request(request)
body = response.read_body
require "json"

body = response.read_body  # From the URL query code above
weather = JSON.parse(body)

weather["days"].each do |days|
  weather_date = days["datetime"]
  weather_desc = days["description"]
  weather_tmax = days["tempmax"]
  weather_tmin = days["tempmin"]

  puts "Forecast for date: #{weather_date}"
  puts " General conditions: #{weather_desc}"
  puts " The high temperature will be #{weather_tmax}"
  puts " The low temperature will be #{weather_tmin}"
end