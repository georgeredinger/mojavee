class LinkCategoryJoin < ActiveRecord::Migration
  def self.up
      create_table :linkcategories_links, :id => false do |t|
          t.integer :linkcategory_id
          t.integer :link_id
      end
  end

  def self.down
     drop_table  :linkcategories_links
      
  end
end
