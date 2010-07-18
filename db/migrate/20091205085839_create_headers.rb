class CreateHeaders < ActiveRecord::Migration
  def self.up
    create_versioned_table :headers do |t|
      # t.belongs_to :producer
      t.belongs_to :header_type
      # t.belongs_to :cart
      t.integer :item_number
      # t.decimal :purchase_price_usd 
      # t.decimal :purchase_price_bob
      t.string :summary_description
      t.text :description, :size => (64.kilobytes + 1)
      t.belongs_to :attachment
      t.integer :attachment_version
    end

    if !ContentType.exists?(:name => "Header")
      ContentType.create!(:name => "Header", :group_name => "Headers")
    end
  end

  def self.down
    ContentType.delete_all(['name = ?', 'Header'])
    CategoryType.all(:conditions => ['name = ?', 'Header']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :header_versions
    drop_table :headers
  end
end
