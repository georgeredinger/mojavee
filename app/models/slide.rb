class Slide < ActiveRecord::Base
   belongs_to :slideshow   
   belongs_to :photo 
end
