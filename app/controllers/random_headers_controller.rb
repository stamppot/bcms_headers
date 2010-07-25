class RandomHeadersController < ActionController::Base #Cms::ContentBlockController

  def show
    puts "params: #{params.inspect}  #{params.class}"
    render :text => RandomHeader.get(Section.find params[:id], true)
  end

end