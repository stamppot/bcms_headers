module Cms::Routes
  def routes_for_bcms_headers
    # add_product_to_cart "/store/add_to_cart", :controller => '/store', :action => 'add_to_cart', :conditions => {:method => :put}
    # add_product_to_cart "/store/remove_from_cart", :controller => '/store', :action => 'remove_from_cart', :conditions => {:method => :put}
    # resources :orders, :new => { :paypal_express => :get, :charge => :post, :ship => :post }
    get_random_header '/headers/random', :controller => 'cms/headers', :action => 'random_header'

    namespace(:cms) do |cms|
      cms.content_blocks :headers
      cms.content_blocks :header_types
      cms.content_blocks :header_collections
    end
  end
end
