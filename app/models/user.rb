class User < ActiveRecord::Base
	has_secure_password
	
	validates_presence_of :email
	validates_uniqueness_of :email
  validates :password, :presence => true, :confirmation => true, :on => :create

	def self.search(search)
  		if search
    		where('email ILIKE ?', "%#{search}%")
 		else
   			User.all
 		end
	end
end