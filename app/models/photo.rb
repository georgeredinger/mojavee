class Photo < ActiveRecord::Base
 #  set_primary_key "created_at" 
    has_many :slides 
    has_and_belongs_to_many :categories 
    validates_presence_of :filename 
end
