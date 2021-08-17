class Quiz < ApplicationRecord

attr_accessor :score_percent, :score_text

after_initialize :calculate_score

has_attached_file :image
serialize :languages

# validates_presence_of :preference, :name
scope :sorted, -> {order("id DESC")}
	def self.support_tickets
		{
			"0" 		=> 0,
			"1-49" 	=> 3,
			"50-99" => 5,
			"100+" 	=> 7,
		}
	end

	def self.experience
		{
			"None" => 0,
			"Several Months - Year" => 3,
			"Year - Two Years" => 5,
			"Two Years+" => 7
		}
	end

	def self.languages
		{ 
			"Ruby" 					=> 3,
			"Ruby on Rails" => 5,
			"JS/JQuery" 		=> 3,		
			"HTML" 					=> 3,
			"CSS" 					=> 2,
			"Java"					=> 3,
			"Python" 				=> 3,
			"SQL" 					=> 3,
		}		
	end

	def self.css_response
		{
		"I agree" => 0,
		"CSS is the bane of my existence. I strongly dislike it"	=> 1,
		}
	end

	def calculate_score
		total = 0
		support_tickets = Quiz.support_tickets[self[:support_tickets]] || 0
		experience = Quiz.experience[self[:experience]] || 0
		language_total = 0
		css_response = Quiz.css_response[self[:css_response]] || 0
		self.languages.each {|l| language_total += Quiz.languages[l]} if !self.languages.blank?
		total = (support_tickets + experience + language_total + css_response) / 40.0 * 100.0
		total = total.round
		self.score_percent = total
		self.score_text = calc_text total
	end

	def calc_text total
		if total == 0
			"No Software Engineering Experience"
		elsif total < 35
			"Minimal Software Engineering Experience"
		elsif total < 90
			"Moderate Software Engineering Experience"
		else
			"Immense Software Engineering Experience"
		end
	end
end
