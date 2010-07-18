class RecentHeadersPortlet < Portlet

  def render
    @headers = Header.all(:order => "created_at desc", :limit => self.limit)
  end
    
end