module HeaderCollectionsHelper
  def header_collection_contains_header_type?(header_type)
    if @header_collection && !@header_collection.header_types.nil? # no sense in testing new users that have no languages
      @header_collection.header_types.include?(header_type)
    else
      false
    end
  end
end