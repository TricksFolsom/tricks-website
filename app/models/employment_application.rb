class EmploymentApplication < ActiveRecord::Base
    has_one :address, :as => :addressable, dependent: :destroy
    accepts_nested_attributes_for :address
    
    has_many :employment_histories, :as => :history, dependent: :destroy
    accepts_nested_attributes_for :employment_histories

    has_many :employment_application_reviews, dependent: :destroy
    
    STATUS = [['New', 0], ['Interested', 1], ['Emailed', 2], ['Interview Set Up', 3], ['Not Hired', 4], ['Maybe Later', 5], ['Hired', 6]]
    
	mount_uploader :image, ApplicantImageUploader
    mount_uploader :resume, ApplicantResumeUploader
    
	has_one_attached :image_new
    has_one_attached :resume_new

    validates_presence_of :firstname

    # allows use of honeypot in the form, but does not save to database
    attr_accessor :honeypot

	def self.search(search)
        if search
            where("concat(firstname, ' ', lastname) ILIKE ?", "%#{search}%")
        else
            EmploymentApplication.all
        end
    end

    # we can't validate this way anymore since we added the priority combinations.
    # Instead, we make sure they can't get rid of the last priority
    # validate :has_location
    # validate :has_department

    # def has_location
    #     if folsom.blank? && sacramento.blank?
    #         errors[:base] << "Must select at least one location"
    #     end
    # end
    # def has_department
    #     if gymnastics.blank? && dance.blank? && swim.blank? && tag.blank? && hospitality.blank?
    #         errors[:base] << "Must select at least one department"
    #     end
    # end
end
