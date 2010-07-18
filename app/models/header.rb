class Header < ActiveRecord::Base
  after_save :change_filename # important must be above acts_as
  
  acts_as_content_block :belongs_to_attachment => true

  validates_each :header_type do |record, attr, value|
    if record.header_type
      record.errors.add attr, 'must be published' unless record.header_type.published?
    else
      record.errors.add attr, 'must be specified'
    end
  end
  belongs_to :header_type

  # Headers should be identified by their item number but BrowserCMS is hell bent on using :name
  # Created this so this module can refer to item_number and name will just contain a copy of item_number
  # so things like searching in the content library work as expected.
  # This module should not use the field product.name (use Header.item_number instead)
  def item_number=(new_item_number)
    write_attribute(:name, Header.prefix + new_item_number.to_s)
    write_attribute(:item_number, new_item_number)
  end

  def self.columns_for_index
    [ {:label => "Type", :method => :header_type_name, :order => "header_type_id" },
      {:label => "Item Number", :method => :item_number },
      {:label => "Name", :method => :name } ]
  end

  def self.default_order
    "item_number asc"
  end

  def header_type_name
    self.header_type.name
  end
  
  def change_filename
    name = Header.prefix + self.item_number.to_s
    filename = name + File.extname(self.attachment.file_path)
    
    path = "/headers/#{self.header_type.item_number}/"
    self.attachment.name = filename
    self.attachment.file_path = path + filename
    self.attachment.send(:update_without_callbacks)
    self.attachment.versions.last.name = filename
    self.attachment.versions.last.file_path = path + filename
    self.attachment.versions.last.send(:update_without_callbacks)
  end
  
  def self.prefix
    "header-"
  end

end
