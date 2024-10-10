def valid_ipv4?(ip)
  sections = ip.split(".")
  return false if sections.size != 4

  sections.each do |section|
    return false if section.to_i.to_s != section || !section.match?(/^\d+$/)
    return false unless (0..255).include?(section.to_i)
  end

  true
end

# Приклад використання
puts valid_ipv4?("192.168.1.1")   # => true
puts valid_ipv4?("256.256.256.256") # => false
puts valid_ipv4?("192.168.01.1")   # => false
puts valid_ipv4?("192.168.1")      # => false
