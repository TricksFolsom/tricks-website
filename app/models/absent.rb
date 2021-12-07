class Absent < ActiveRecord::Base
  #attr_accessible :first_name, :last_name, :location, :classtype_id, :level_id, :date, :time
  belongs_to :classtype
  belongs_to :level
  # has_one :schedule

  validates_presence_of :first_name, :last_name, :location, :classtype_id, :level_id, :date, :time, :reason

  LOCATIONS = [['Granite Bay', 0], ['Folsom', 1], ['Sacramento', 2]]
  HUMAN_LOCATIONS = ['Granite Bay', 'Folsom', 'Sacramento']
  
end
