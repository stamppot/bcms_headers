class HeaderCollection < ActiveRecord::Base
  # acts_as_content_block
  
  # validates_presence_of :header_type
  validates_presence_of :name
  validates_presence_of :section_id
  
  has_and_belongs_to_many :header_types

  # def before_save
  #   self.header_types.each { |h}
end