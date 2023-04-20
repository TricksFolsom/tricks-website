class Event < ActiveRecord::Base

  
	has_one_attached :image
	validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..10.megabytes }

	TYPES = ['Camp', 'Kids Night Out', 'Party', 'Pop\'n\'Play']

end
