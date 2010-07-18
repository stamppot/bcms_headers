class Cms::HeaderTypesController < Cms::ContentBlockController

  def create
    max_item = (HeaderType.maximum(:item_number) || "0").to_i
    params[:header_type][:item_number] = (max_item + 1).to_s
    super
  end

  # def update
  #   super
  # end

end