  
class CreateCategories < ActiveRecord::Migration   
  def self.up 
    create_table :categories do |t| 
      t.string  :name
      t.integer :parent_id
    end 
    create_table  :categories_photos do |t| 
      t.integer :category_id 
      t.integer :photo_id 
    end 
    
    Category.new do |category| 
      category.name = "All" 
      Photo.find(:all).each do |photo| 
        photo.categories << category 
        photo.save 
      end 
    end 
  end 
  
  def self.down 
    drop_table :categories
    drop_table :categories_photos
  end 
end 

