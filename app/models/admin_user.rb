class AdminUser < ApplicationRecord
	# self.table_name = "admin_users"
		has_secure_password
		validates_presence_of :password_confirmation
		has_and_belongs_to_many :pages
		has_many :section_edits
		has_many :sections, :through => :section_edits
		scope :sorted, lambda {order("last_name ASC, first_name ASC")}

		def name
			"#{first_name} #{last_name}"
		end
end
