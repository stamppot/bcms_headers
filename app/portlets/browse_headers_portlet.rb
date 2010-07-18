class BrowseHeadersPortlet < Portlet
  def render
    @header_types = HeaderType.find(:all)

    if params[:type]
      # We should search by product type
      @headers_to_browse = Header.find(:all, :conditions => ["published = ? AND header_type_id = ?", true, params[:type]])
      @search_results_summary = 'Found ' + @headers_to_browse.size.to_s + ' headers of type ' + HeaderType.find(params[:type]).name
    end
  end
end