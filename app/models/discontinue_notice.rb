class DiscontinueNotice < ActiveRecord::Base
	#attr_accessible :class_day, :class_time, :last_day, :location, :parent_name, :reason, :student_first_name, :student_last_name, :understood

    validates_presence_of :class_day, :class_time, :last_day, :location, :parent_name, :reason, :student_last_name, :student_first_name, :understood

	LOCATIONS = [['Folsom', 1], ['Sacramento', 2]]
	DAYS = [['Monday', 0], ['Tuesday', 1], ['Wednesday', 2], ['Thursday', 3], ['Friday', 4], ['Saturday', 5]]
end
