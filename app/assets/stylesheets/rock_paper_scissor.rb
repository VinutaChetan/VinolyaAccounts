# Rock Paper Scissors

# Let's play! You have to return which player won! In case of a draw return Draw!.

# Examples:

# rps('scissors','paper') // Player 1 won!
# rps('scissors','rock') // Player 2 won!
# rps('paper','paper') // Draw!

def rps(play1,play2)
	if play1=="scissor" && play2=="paper"
		puts "Player 1 won!"
	elsif play1=="scissor" && play2=="rock"
		puts "Player 2 won!"
	else 
		puts "Draw!"
	end		
end	


puts "Select your first player"
player1 = gets.chomp

puts "Select your second player"
player2 = gets.chomp

puts rps(player1,player2)

