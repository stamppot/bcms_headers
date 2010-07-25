class RandomHeadersController < ActionController::Base #Cms::ContentBlockController

  def show
    puts "params: #{params.inspect}  #{params.class}"
    params.delete "_"
    page = Page.find params[:id]
    render :text => RandomHeader.get(page, true)
  end

end