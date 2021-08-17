class Subject < ApplicationRecord
	has_many :pages, :dependent => :destroy

	scope :visible, -> {where(:visible => true)}
	# scope :invisible, -> {where(:visible => false)}
	scope :sorted, -> {order("subject ASC")}
	# scope :newest_first, -> {order("created_at DESC")}
	# scope :search, lambda { |query| where(["name LIKE ?", "%#{query}"])}

end
