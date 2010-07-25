class RandomHeadersController < ActionController::Base

  def show

    params.delete "_"
    page = Page.find params[:id]
    header = RandomHeader.get(page, true)
    debugger
    render :text => header
  end

end