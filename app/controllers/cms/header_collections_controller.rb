class Cms::HeaderCollectionsController < Cms::ContentBlockController

  def new
    @header_collection = HeaderCollection.new
    @header_types = HeaderType.not_deleted(:order => "name")#.map{|e| [e.name, e.id]}
    super
  end
  
  def create
    @section = Section.find params[:header_collection][:section_id]
    @header_types = HeaderType.find(params[:header_collection][:header_type_ids])
    @header_collection = HeaderCollection.new(params[:header_collection])
    @header_collection.header_types = @header_types
    @header_collection.header_types.each &:save
    @header_collection.save
    # super
    redirect_to :action => :index
  end
  
  def edit
    @header_collection = HeaderCollection.find params[:id]
    @header_types = HeaderType.not_deleted(:order => "name")#.map{|e| [e.name, e.id]}
    super
  end
  
  def update
    @header_collection = HeaderCollection.find params[:id]
    params[:header_collection][:header_type_ids] ||= []

    @section = Section.find params[:header_collection][:section_id]
    @header_types = HeaderType.find(params[:header_collection][:header_type_ids])

    if @header_collection.update_attributes params[:header_collection]
      redirect_to :action => :index and return
    else
      flash.now[:error] = @header_collection.errors
      setup_form_values
      respond_to do |format|
        format.html { render :action => :edit} and return
      end
    end
    # super
  end
end