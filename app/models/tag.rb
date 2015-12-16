class Tag < ActiveRecord::Base
	belongs_to :photo
	belongs_to :user

	validates :user_id, presence: true
	validates :photo_id, presence: true
	validates :width, presence: true
	validates :height, presence: true
	validates :x_coord, presence: true
	validates :y_coord, presence: true


end
