class HeaderType < ActiveRecord::Base
  after_save :change_filename # important must be above acts_as
  
  acts_as_content_block :belongs_to_attachment => true
  has_many :headers
  belongs_to :section  # remove, check how file_path is created
  has_and_belongs_to_many :header_collections
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :item_number
  validates_uniqueness_of :item_number

  def change_filename
    name = "headertype-#{self.item_number}" + File.extname(self.attachment.file_path)
    path = "/headers/"
    self.attachment.name = name
    self.attachment.file_path = path + name
    self.attachment.send(:update_without_callbacks)
    self.attachment.versions.last.name = name
    self.attachment.versions.last.file_path = path + name
    self.attachment.versions.last.send(:update_without_callbacks)
  end
end
