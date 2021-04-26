class Coach < ActiveRecord::Base
	#attr_accessible :image, :firstname, :lastname, :gender, :location_ids, :level_ids, :classtype_ids, :experience, :fav_event, :fav_skill, :fav_food, :disney_char, :advice, :birthdate, :startdate, :remove_image, :strengths, :current_employee
	has_many :coach_levels
	has_many :levels, through: :coach_levels
	accepts_nested_attributes_for :coach_levels

	has_many :coach_locations
	has_many :locations, through: :coach_locations
	accepts_nested_attributes_for :coach_locations

	has_many :coach_classtypes
	has_many :classtypes, through: :coach_classtypes
	accepts_nested_attributes_for :coach_classtypes
	
	validates :firstname,:presence => {:message => "cannot be blank."}#, :format => /^[A-Za-z\d_-]+$/
	validates :lastname,:presence => {:message => "cannot be blank."}#, :format => /^[A-Za-z\d_-]+$/
	validates_presence_of :gender, :location_ids, :classtype_ids
	# validates_presence_of :level_ids, :unless => lambda { self.classtype_ids == ["", "9"] }
	# puts "LOG: " + (lambda { |c| c.classtype_ids == ["", "9"] }).to_s
	mount_uploader :image, CoachImageUploader
	mount_uploader :tag_image, CoachImageUploader

	has_one_attached :image_new
	has_one_attached :tag_image_new

	default_scope {order('coaches.id')}


	def self.location_search(location_search)
  		if location_search
    		where('name ILIKE ?', "%#{location_search}%")
 		else
	 		Coach.all
 		end
	end

end
