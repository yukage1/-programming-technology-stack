require 'minitest/autorun'

class TestValidIPv4 < Minitest::Test
  def test_valid_ipv4
    # Коректні IP-адреси
    assert_equal true, valid_ipv4?("192.168.1.1"), "192.168.1.1 should be valid"
    assert_equal true, valid_ipv4?("0.0.0.0"), "0.0.0.0 should be valid"
    assert_equal true, valid_ipv4?("255.255.255.255"), "255.255.255.255 should be valid"

    # Некоректні IP-адреси
    assert_equal false, valid_ipv4?("256.256.256.256"), "256.256.256.256 should be invalid"
    assert_equal false, valid_ipv4?("192.168.01.1"), "192.168.01.1 should be invalid"
    assert_equal false, valid_ipv4?("192.168.1"), "192.168.1 should be invalid"
    assert_equal false, valid_ipv4?("192.168.1.1.1"), "192.168.1.1.1 should be invalid"
    assert_equal false, valid_ipv4?("192.168.-1.1"), "192.168.-1.1 should be invalid"
    assert_equal false, valid_ipv4?("192.168.1.a"), "192.168.1.a should be invalid"
    assert_equal false, valid_ipv4?("abc.def.ghi.jkl"), "abc.def.ghi.jkl should be invalid"
    assert_equal false, valid_ipv4?(""), "Empty string should be invalid"
    assert_equal false, valid_ipv4?(nil), "Nil should be invalid"
  end

  def valid_ipv4?(ip)
    return false unless ip.is_a?(String)
    sections = ip.split(".")
    return false if sections.size != 4

    sections.each do |section|
      return false if section.to_i.to_s != section || !section.match?(/^\d+$/)
      return false unless (0..255).include?(section.to_i)
    end

    true
  end
end

