class AddPhotoColumns < ActiveRecord::Migration
  def self.up
      add_column "photos", "thumbnail", :string  
      add_column "photos", "description", :string
     Photo.find(:all).each do |photo|       photo.update_attribute :created_at, Time.now 
     photo.update_attribute :thumbnail, photo.filename.gsub('.', '_m.') 
    end 
  end

  def self.down
     remove_column "photos", "thumbnail"  
     remove_column "photos", "description"
  end
end
