class WebsitePdf < ActiveRecord::Base
  #attr_accessible :file, :file_name

  validates_presence_of :file_new, :file_name
  mount_uploader :file, WebsitePdfUploader

  has_one_attached :file_new

  FILENAMES = [
    'Tricks Newsletter',
# 	'Tricks Registration Form',
    'Tricks Release Form',
    'Tricks Family Rules',
    'Tricks Billing Cycle',
    #'Tricks Instructor Application',
    #'Tricks Office Application',
    'Tricks Dance Dress Code',
    'Tricks Recital Packet',
    '-------------',
    'Tumblebunnies Schedule (Granite Bay)',
    'Tumblebunnies Schedule (Folsom)',
    'Tumblebunnies Schedule (Sacramento)',
    'School Age Gymnastics Schedule (Granite Bay)',
    'School Age Gymnastics Schedule (Folsom)',
    'School Age Gymnastics Schedule (Sacramento)',
    'Dance Schedule (Granite Bay)',
    'Dance Schedule (Folsom)',
    'Dance Schedule (Sacramento)',
    'TAG Schedule (Granite Bay)',
    'TAG Schedule (Folsom)',
    'TAG Schedule (Sacramento)',
    'Swim Schedule (Folsom)',
    '-------------',
    'Show Schedule - TAG (Folsom)',
    'Show Schedule - Tumblebunny Gymnastics (Folsom)',
    'Show Schedule - School Age Gymnastics (Folsom)',
    '-------------',
    'Littlest Nutcracker',
    'Winter Dance Recital',
    'General Recital Info',
    'Show Assignments and Costume Details',
    'Parties'
  ]
  def to_param
    "#{file_name}"
  end
end
