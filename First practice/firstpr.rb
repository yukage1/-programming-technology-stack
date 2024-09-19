

choices = ["stone", "scissors", "paper"]


puts "Choose one option: rock, scissors or paper"
user_choice = gets.chomp.downcase


comp_choice = choices.sample


puts "You have chosen: #{user_choice}"
puts "The computer has chosen: #{comp_choice}"


if user_choice == comp_choice
  puts "Draw!"
elsif (user_choice == "stone" && comp_choice == "scissors") ||
  (user_choice == "scissors" && comp_choice == "paper") ||
  (user_choice == "paper" && comp_choice == "stone")
  puts "You won!"
else
  puts "You lost!"
end

