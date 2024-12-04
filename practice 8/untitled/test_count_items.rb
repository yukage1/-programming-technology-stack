require 'minitest/autorun'
require_relative 'count_items'

class TestCountItemsInDirectory < Minitest::Test
  def setup
    # Створюємо тимчасову директорію для тестів
    @test_dir = 'test_directory'
    Dir.mkdir(@test_dir)

    # Створюємо піддиректорії та файли
    Dir.mkdir(File.join(@test_dir, 'subdir1'))
    Dir.mkdir(File.join(@test_dir, 'subdir2'))
    File.write(File.join(@test_dir, 'file1.txt'), 'Test file 1')
    File.write(File.join(@test_dir, 'file2.txt'), 'Test file 2')
    File.write(File.join(@test_dir, 'subdir1', 'file3.txt'), 'Test file 3')
  end

  def teardown
    # Видаляємо тимчасову директорію після тестів
    Dir.glob(File.join(@test_dir, '**', '*')).each do |file|
      File.delete(file) if File.file?(file)
    end
    Dir.glob(File.join(@test_dir, '**', '*')).each do |dir|
      Dir.rmdir(dir) if File.directory?(dir)
    end
    Dir.rmdir(@test_dir)
  end

  def test_count_items_in_directory
    result = count_items_in_directory(@test_dir)
    assert_equal 3, result[:files], 'Неправильна кількість файлів'
    assert_equal 3, result[:directories], 'Неправильна кількість директорій'
  end

  def test_directory_does_not_exist
    assert_raises(ArgumentError) do
      count_items_in_directory('non_existent_directory')
    end
  end
end