module Cms::Routes
  def routes_for_bcms_mano_weavings
    namespace(:cms) do |cms|
      cms.content_blocks :weavers
      cms.content_blocks :weaving_types
    end  
  end
end
