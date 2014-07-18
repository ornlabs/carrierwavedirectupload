class Rating < ActiveRecord::Base
  mount_uploader :image, RatingImageUploader
end
