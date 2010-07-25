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

  
  def self.random(page, divide_equally = true)
    sections = page.ancestors.reverse.each do |section|
      if header_collection = HeaderCollection.find_by_section_id(section.id)
        return random_header(header_collection, divide_equally)
      end
    end
  end
  
  private 
  def random_header(collection, divide_equally = true)
    path = "/headers/"

    if divide_equally # equal change to get header from header types
      random_header_equal_groups(collection, path)
    else # equal change for all headers
      random_all_headers(collection, path = nil)
    end
  end

  def random_key(hash) # get random key
    key = hash.keys[rand(hash.size)]
  end  

  def random_hash(collection)
    # get random key
    key = collection.keys[rand(collection.size)]
    { key => collection[key] }
  end

  def random_element(array)
    array[rand(array.size)]
  end

  def random_all_headers(header_collection, path = nil)
    path ||= "/headers/"
    headers = header_collection.header_types.map { |type| type.headers }.flatten
    header = random_element(array)
    path += "#{header.header_type.item_number}/" + header.attachment.name
  end

  # equal chance to get header from header types
  def random_header_equal_groups(header_collection, path = nil)
    path ||= "/headers/"

    headers_hash = header_collection.header_types.inject({}) do |result, type|
      result[type.item_number] = type.headers
      result
    end
    rand_item = random_key(headers_hash)
    headers = headers_hash[rand_item]
    path += "#{rand_item}/" + random_element(headers).attachment.name
  end
end
