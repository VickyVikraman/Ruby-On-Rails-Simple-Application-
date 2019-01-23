class Detail < ActiveRecord::Base
    mount_uploader :image, ProfilePictureUploader
    serialize :image, JSON
  
end
