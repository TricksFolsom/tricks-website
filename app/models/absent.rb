class Absent < ActiveRecord::Base
  belongs_to :classtype
  belongs_to :level

  validates_presence_of :first_name, :last_name, :location, :classtype_id, :level_id, :date, :time, :reason

  LOCATIONS = [['Folsom', 1], ['Sacramento', 2]]
  HUMAN_LOCATIONS = ['None', 'Folsom', 'Sacramento']
  
end
