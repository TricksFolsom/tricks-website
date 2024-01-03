class Level < ActiveRecord::Base
    has_many :coach_levels
    has_many :coaches, through: :coach_levels
    has_many :absents
    belongs_to :classtype
    #validates_uniqueness_of :levelname, :jack_rabbit_name
    validates_presence_of :classtype_id, :levelname, :gender, :sort_order
    #attr_accessible :description, :short_description, :video_url, :classtype_id, :levelname, :length, :age, :gender, :sort_order, :jack_rabbit_name, :color, :image, :show_registration
    
    default_scope {order('levels.sort_order')} # assuming the column name is order
    
    mount_uploader :image, LevelImageUploader
    # def to_param
    #   self.levelname
    # end
end
