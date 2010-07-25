# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def get_random_header(section, divide_equally = true)
    RandomHeader.get(section, divide_equally)
  end
    
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
