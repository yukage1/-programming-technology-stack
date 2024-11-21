require 'minitest/autorun'
require 'csv'

class WeatherAPITest < Minitest::Test
  def setup
    @test_file_name = 'weather_data.csv'
  end

  def test_csv_creation
    # Очікувані дані
    expected_data = [
      'Місто - Kyiv',
      'Температура (°C) - 1.51',
      'Вологість (%) - 94',
      'Швидкість вітру (м/с) - 0.89'
    ]

    # Перевірка, чи файл існує
    assert File.exist?(@test_file_name), "Файл #{@test_file_name} не створено"

    # Зчитування фактичних даних із файлу
    actual_data = CSV.read(@test_file_name, headers: false).flatten

    # Перевірка, чи вміст файлу відповідає очікуваним даним
    expected_data.each_with_index do |expected_line, index|
      assert_equal expected_line, actual_data[index], "Невірні дані у CSV файлі на рядку #{index + 1}"
    end
  end

  def teardown
    puts "Тестування завершено."
  end
end
