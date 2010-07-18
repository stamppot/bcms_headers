class CreateHeaderCollections < ActiveRecord::Migration
  def self.up
    create_table :header_collections do |t|
      t.string :name 
      t.string :danish_name 
      t.text :description, :size => (64.kilobytes + 1)
      t.belongs_to :section
    end
    create_table :header_collections_header_types, :id => false do |t|
      t.integer :header_collection_id
      t.integer :header_type_id
    end

    if !ContentType.exists?(:name => "HeaderCollection")
      ContentType.create!(:name => "HeaderCollection", :group_name => "Headers")
    end
  end

  def self.down
    drop_table :header_collections_header_types

    ContentType.delete_all(['name = ?', 'HeaderCollection'])
    CategoryType.all(:conditions => ['name = ?', 'Header Collection']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    # drop_table :header_type_versions
    drop_table :header_collections
  end
end