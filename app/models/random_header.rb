class RandomHeader
  def self.get(section, divide_equally = true)
    if section.is_a? Array
      puts "Section is an array: #{section.inspect} "
      section = section.first
    end
    sections = section.ancestors.reverse.each do |asection|
      if header_collection = HeaderCollection.find_by_section_id(asection.id)
        return self.random_header(header_collection, divide_equally)
      end
    end
  end

  private 
  def self.random_header(collection, divide_equally = true)
    path = "/headers/"

    if divide_equally # equal change to get header from header types
      self.random_header_equal_groups(collection, path)
    else # equal change for all headers
      self.random_all_headers(collection, path = nil)
    end
  end

  def self.random_key(hash) # get random key
    key = hash.keys[rand(hash.size)]
  end  

  def self.random_hash(collection)
    # get random key
    key = collection.keys[rand(collection.size)]
    { key => collection[key] }
  end

  def self.random_element(array)
    array[rand(array.size)]
  end

  def random_all_headers(header_collection, path = nil)
    path ||= "/headers/"
    headers = header_collection.header_types.map { |type| type.headers }.flatten
    header = self.random_element(array)
    path += "#{header.header_type.item_number}/" + header.attachment.name
  end

  # equal chance to get header from header types
  def self.random_header_equal_groups(header_collection, path = nil)
    path ||= "/headers/"

    headers_hash = header_collection.header_types.inject({}) do |result, type|
      result[type.item_number] = type.headers
      result
    end
    rand_item = self.random_key(headers_hash)
    headers = headers_hash[rand_item]
    path += "#{rand_item}/" + self.random_element(headers).attachment.name
  end
end