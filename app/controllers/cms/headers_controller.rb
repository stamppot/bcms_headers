class Cms::HeadersController < Cms::ContentBlockController
  def create
    # increment item number
    header_type_id = params[:header][:header_type_id]
    max_item = Header.maximum(:item_number, :conditions => {:header_type_id => header_type_id}) || 0
    params[:header][:item_number] = "#{max_item + 1}"
    
    header_type = HeaderType.find(header_type_id)
    params[:header][:name] = header_type.name + " " + params[:header][:item_number].to_s
    super
  end

end