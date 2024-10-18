require 'minitest/autorun'
require 'net/http'
require 'json'
require 'csv'

class WeatherTest < Minitest::Test
  def setup
    @api_key = '1447211beeec03c5344c62373d56a2cc'
    @city = 'Kyiv'
    @url = URI("http://api.openweathermap.org/data/2.5/weather?q=#{@city}&appid=#{@api_key}&units=metric")
  end

  # Test 1: Перевірка коректності виконання HTTP-запиту до API
  def test_http_request
    response = Net::HTTP.get_response(@url)
    assert response.is_a?(Net::HTTPSuccess), 'Запит не повернув успішний статус'
  end

  # Test 2: Перевірка правильності обробки даних
  def test_data_parsing
    response = Net::HTTP.get(@url)
    data = JSON.parse(response)

    # Перевіряємо, що ключі присутні в отриманих даних
    assert data['main'], 'Відповідь не містить ключа "main"'
    assert data['main']['temp'], 'Відповідь не містить ключа "temp"'
    assert data['wind'], 'Відповідь не містить ключа "wind"'
    assert data['wind']['speed'], 'Відповідь не містить ключа "speed"'
    assert data['weather'], 'Відповідь не містить ключа "weather"'
  end

  # Test 3: Перевірка коректності збереження даних у CSV файл
  def test_csv_creation
    response = Net::HTTP.get(@url)
    data = JSON.parse(response)

    # Розгортаємо JSON у плоску структуру
    flattened_data = flatten_json(data)


    csv_file = 'test_weather_data.csv'
    CSV.open(csv_file, 'w', write_headers: true, headers: flattened_data.keys) do |csv|
      csv << flattened_data.values
    end

    # Перевірка, чи файл створено
    assert File.exist?(csv_file), 'CSV файл не створений'

    # Перевірка вмісту файлу
    saved_data = CSV.read(csv_file, headers: true).first.to_h
    flattened_data.each do |key, value|
      assert_equal value.to_s, saved_data[key], "Значення в CSV не відповідає для ключа #{key}"
    end

    # Видалення тестового файлу після перевірки
    File.delete(csv_file) if File.exist?(csv_file)
  end

  private

  # Функція для розгортання JSON у плоску структуру
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
end


