
# Array with possible selections
choices = ['stone', 'scissors', 'paper']

# We ask the user to make a choice
puts "Choose one option: rock, scissors or paper"
user_choice = gets.chomp.downcase

# The computer randomly selects one of the options
computer_choice = choices.sample

# Displaying player and computer choices
puts "You have chosen: #{user_choice}"
puts "The computer has chosen: #{computer_choice}"

# Determining the winner
if user_choice == computer_choice
  puts "Draw!"
elsif (user_choice == 'stone' && computer_choice == 'scissors') ||
  (user_choice == 'scissors' && computer_choice == 'paper') ||
  (user_choice == 'paper' && computer_choice == 'stone')
  puts "You won!"
else
  puts "You lost!"
end

