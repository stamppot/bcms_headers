class HeaderDetailsPortlet < Portlet

  def render
    @header = Header.find(params[:id])
  end

end