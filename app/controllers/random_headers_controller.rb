class RandomHeadersController < ActionController::Base #Cms::ContentBlockController

  def show
    puts "params: #{params.inspect}  #{params.class}"
    params.delete "_"
    section = Section.find params[:id]
    render :text => RandomHeader.get(section, true)
  end

end