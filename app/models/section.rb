class Section < ApplicationRecord
	belongs_to :page
	has_many :section_edits
	has_many :admin_users, :through => :section_edits
	# scope :visible, -> {where(:visible => true)}
	# scope :invisible, -> {where(:visible => false)}
	scope :sorted, -> {order("id ASC")}
	scope :visible, lambda {where("visible=?",1)}
	# scope :newest_first, -> {order("created_at DESC")}
	# scope :search, lambda { |query| where(["name LIKE ?", "%#{query}"])}

end
