class CreateHeaderTypes < ActiveRecord::Migration
  def self.up
    create_versioned_table :header_types do |t|
      t.string :name 
      t.string :danish_name 
      t.string :item_number
      t.text :description, :size => (64.kilobytes + 1)
      # t.belongs_to :section
      t.belongs_to :attachment
      t.integer :attachment_version
    end

    if !ContentType.exists?(:name => "HeaderType")
      ContentType.create!(:name => "HeaderType", :group_name => "Headers")
    end
  end

  def self.down
    ContentType.delete_all(['name = ?', 'HeaderType'])
    CategoryType.all(:conditions => ['name = ?', 'Header Type']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :header_type_versions
    drop_table :header_types
  end
end
