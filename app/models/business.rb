class Business < ActiveRecord::Base
	mount_uploader :image, ImageUploader
end
