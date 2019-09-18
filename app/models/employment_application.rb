class EmploymentApplication < ActiveRecord::Base
    has_one :address, :as => :addressable
    accepts_nested_attributes_for :address
    
    has_many :employment_histories, :as => :history
    accepts_nested_attributes_for :employment_histories

    has_many :employment_application_reviews
    
    STATUS = [['New', 0], ['Interested', 1], ['Emailed', 2], ['Interview Set Up', 3], ['Not Hired', 4], ['Maybe Later', 5], ['Hired', 6]]
    
	mount_uploader :image, ApplicantImageUploader
    mount_uploader :resume, ApplicantResumeUploader
    
	def self.search(search)
        if search
            where("concat(firstname, ' ', lastname) ILIKE ?", "%#{search}%")
        else
            EmploymentApplication.all
        end
    end

    validate :has_location
    validate :has_department

    def has_location
        if granite_bay.blank? && folsom.blank? && sacramento.blank?
            errors[:base] << "Must select at least one location"
        end
    end
    def has_department
        if gymnastics.blank? && dance.blank? && swim.blank? && tag.blank? && hospitality.blank?
            errors[:base] << "Must select at least one department"
        end
    end
end
