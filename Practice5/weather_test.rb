require 'minitest/autorun'
require 'csv'

class WeatherAPITest < Minitest::Test
  def setup
    @test_file_name = 'weather_data.csv'
  end

  def test_csv_creation
    # Очікувані дані
    expected_data = [
      'City - Kyiv',
      'Temperature (°C) - 1.50',
      'Humidity (%) - 93',
      'Wind speed (м/с) - 0.89'
    ]


    assert File.exist?(@test_file_name), "File #{@test_file_name} not created"


    actual_data = CSV.read(@test_file_name, headers: false).flatten


    expected_data.each_with_index do |expected_line, index|
      assert_equal expected_line, actual_data[index], "Invalid data in CSV file on row #{index + 1}"
    end
  end

  def teardown
    puts "Testing is complete."
  end
end
