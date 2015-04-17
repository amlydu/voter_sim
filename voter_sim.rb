=begin 
A. This is the main menu: #Loop back to main menu? Method?
	1. What would you like to do? Create, List, Update, or Vote
		- When I type Create:
			- What would you like to create? Politician or Person
	2. When I type Politician: #new class
		- Name?
		- Party? Democrat or Republican
	3. When I type Person:
		- Name?
		- Politics? Liberal, Conservative, Tea Party, Socialist, or Neutral

B. When creating something is done, return to the main menu. 
=end

#enter sim
#display options

class VotingSim
	def initialize
	end

	def intro
		puts "Welcome to the Voter Simulation!"
	end
end

class Person
end

# class Voter < Person
# end

# class Politician < Voter
# end




def test
	vote = VotingSim.new
	#have an intro to Votersim
	vote.intro

end

test

=begin
C. When I type List, output a list of all the created characters. #class variable
		List
		* Politician, Marco Rubio, Republican
		* Voter, Juha Mikkola, Socialist
D. When I type Update, allow me to update a character.
		Update

		Name?
		Marco Rubio

		New name?

		New Party?    # if a politician
		New Politics? # if a voter
E. When I type Vote, start the simulation.
	1. First, run a campaign. Every politician should visit every voter and do a stump speech.
	2. If a politician is a Republican, he has a
		- 90% chance of convincing a Tea Party voter to vote for him
		- 75% chance of convincing a Conservative voter to vote for him
		- 50% chance of convincing a Neutral voter to vote for him
		- 25% chance of convincing a Liberal voter to vote for him
		- 10% chance of convincing a Socialist voter to vote for him

		If a politician is a Democrat, he has a
		- 90% chance of convincing a Socialist voter to vote for him
		- 75% chance of convincing a Liberal voter to vote for him
		- 50% chance of convincing a Neutral voter to vote for him
		- 25% chance of convincing a Conservative voter to vote for him
		- 10% chance of convincing a Tea Party voter to vote for him
	3. After every stump speech
		- puts a comment from the Voter indicating whether or not he has changed his mind
		- if the Voter is also Politician, puts a comment condemning what was said in the speech

=end















