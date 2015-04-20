
class VotingSim

	def intro
		puts "Welcome to the Voter Simulation! Please press enter to continue."
		gets.chomp
	end

	def main_menu
		options = ["create", "c", "list", "l", "update", "u", "vote", "v", "help", "h"]
		response = nil
		until options.include?(response)
			puts "What would you like to do? --Create","\t\t\t   --List","\t\t\t   --Update","\t\t\t   --Vote", "\t\t\t   --Help"
			response = gets.chomp.downcase
		end
		menu_response_action(response) #passing response variable as an arg into the menu_response_action method
	end

	def menu_response_action(response) #this is called in the main_menu method, which will continue to loop anyway until response is given
		#case statements
		case response
		when "create", "c"
			#method(s) for creating politicians and voters
			create
		when "list", "l"
			#method to list out all created characters; complains if the list is empty
			if (Person.all.any? || Politician.all.any?)
				Person.list
				Politician.list
			else
				puts "Sorry, there are no characters to list. Please create some!"
			end
			main_menu
		when "update", "u"
			update
			main_menu
			#method to update created characters
		when "vote", "v"
			puts "Voting isn't allowed here, this is a dictatorship."
			#jesus christ I don't want to know....
			main_menu
		when "help", "h"
			puts  "Directions: ",
						"\t--Create: Create a new politician or person",
						"\t--List: List all existing characters in this program",
						"\t--Update: Update an existing character",
						"\t--Vote: make yourself feel like you might matter in a convoluted political system!"
			main_menu
		end
	end

	def create
		options = ["person", "politician"]
		response = nil
		until options.include?(response)
			puts "What would you like to create? A Politician or a Person?"
			response = gets.chomp.downcase
		end
		create_response_action(response)
		main_menu
	end

	def create_response_action(response)
		case response
		when "politician"
			Politician.make_politician
		when "person"
			Person.make_person
		end
	end

	def update
		#Update a politician or person; Check if name is within the politician or person class objects
		who_to_update = ask("Would you like to update a --Person or --Politician?")

		case who_to_update
		when "person"
			if Person.all.any?
				person_to_update = ask("What is the name of the person you would like to update?")
				person_to_update.capitalize!
				if Person.find_person(person_to_update) == person_to_update
					Person.update_person(person_to_update)
				end
			else
				puts "Sorry, there are no people to update. Please create some!"
			end
		when "politician"
			if Politician.all.any?
				politician_to_update = ask("What is the name of the politician you would like to update?")
				politician_to_update.capitalize!
				if Politician.find_politician(politician_to_update) == politician_to_update
					Politician.update_politician(politician_to_update)
				else 
					puts "Sorry, there doesn't seem to be a politician by that name here."
				end
			else
				puts "Sorry, there are no politicians to update. Please create some!"
			end
		end
	end

end


#######################################
#Methods to put into a module eventually?
#######################################

def ask(question) #refactor code with this
	puts question
	gets.chomp.downcase
end

#######################################
#Person and Politician Classes
#######################################

class Person
	@@people = [] #
	attr_accessor :name, :political_party
	def initialize(name, political_party)
		@name = name
		@political_party = political_party

		@@people << self #pushing person objects into class variable array
	end

	#make an instance of Person class and store the instance object in the @@people array
	def self.make_person
		political_stance = ["Liberal", "Conservative", "Tea party", "Socialist", "Neutral"]
		name = nil
		until name =~ /[a-zA-Z]+/
			name = ask("Name?").capitalize
		end

		politics = nil
		until political_stance.include?(politics)
			politics = ask("Political Stance? Please choose one of the following: #{political_stance.join(', ')}").capitalize
		end
		self.new(name, politics)
		puts "You created #{name} with a #{politics} political stance"
	end

	#access class variable
	def self.all
		@@people
	end

	#list out all people wthin the Person class
	def self.list
		self.all.each do |person|
			puts "#{person.class}: #{person.name} - #{person.political_party}"
		end
	end

	#use for deciding whether or not to continue in the update process
	def self.find_person(name_of_person)
		self.all.each do |person|
			if person.name == name_of_person
				return person.name
			else
				puts "Sorry, there doesn't seem to be a person by that name here."
			end
		end
	end

	#update Person instances with person.name and person.political_party (loop through to find matching names)
	def self.update_person(name_to_find) #find the person object #need to compare name with user input
		specify_update = ask("What would you like to update: --Name  --Political Stance")
		case specify_update
		when "name"
			new_name = ask("Please enter an updated name:")
			self.all.each do |person|
				if name_to_find == person.name
					person.name = new_name.capitalize
					puts "You have successfully updated the name to #{new_name.capitalize}"
				end
			end
		when "political stance", "political", "stance"
			political_stance = ["Liberal", "Conservative", "Tea party", "Socialist", "Neutral"]
			new_stance = nil
			until political_stance.include?(new_stance)
				new_stance = ask("Please enter new political stance from one of the following: #{political_stance.join(', ')}").capitalize
			end
			self.all.each do |person|
				if name_to_find == person.name
					person.political_party = new_stance
					puts "You have successfully updated the political stance to #{new_stance}"
				end
			end
		else
			puts "Sorry, I don't understand that command"
		end
	end

end

class Politician < Person 
	@@politicians = [] 
	attr_accessor :name, :political_party
	def initialize(name, political_party)
		@name = name
		@political_party = political_party

		@@politicians << self 
	end

	def self.make_politician
		political_stance = ["Democrat", "Republican"]
		name = nil
		until name =~ /[a-zA-Z]+/
			name = ask("Name?").capitalize
		end

		politics = nil
		until political_stance.include?(politics)
			politics = ask("Political Stance? Please choose one of the following: #{political_stance.join(' or ')}").capitalize
		end
		self.new(name, politics)
		puts "You created #{name} who is a #{politics}"
	end

	def self.all
		@@politicians
	end

	def self.list
		self.all.each do |politician|
			puts "#{politician.class}: #{politician.name} - #{politician.political_party}"
		end
	end

	#use for deciding whether or not to continue in the update process
	def self.find_politician(name_of_politician)
		self.all.each do |politician|
			if politician.name == name_of_politician
				return politician.name
			end
		end
	end

	def self.update_politician(name_to_find) #find the politician object #need to compare name with user input
		specify_update = ask("What would you like to update: --Name  --Political Party")
		case specify_update
		when "name"
			new_name = ask("Please enter an updated name:")
			self.all.each do |politician|
				if name_to_find == politician.name
					politician.name = new_name.capitalize
					puts "You have successfully updated the name to #{new_name.capitalize}"
				end
			end
		when "political party", "political", "party"
			political_party = ["Democrat", "Republican"]
			new_stance = nil
			until political_party.include?(new_stance)
				new_stance = ask("Please enter new political party from one of the following: #{political_party.join(' or ')}").capitalize
			end
			self.all.each do |politician|
				if name_to_find == politician.name
					politician.political_party = new_stance
					puts "You have successfully updated the political party to #{new_stance}"
				end
			end
		else
			puts "Sorry, I don't understand that command"
		end
	end

end

#######################################
#Start voter sim method
#######################################

def start_voter_sim
	voter_sim = VotingSim.new
	voter_sim.intro
	voter_sim.main_menu
end

start_voter_sim

=begin

E. When I type Vote, start the simulation.
	1. First, run a campaign. Every politician each do should visit every each do voter and do a stump speech.
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















