class TagsController < ApplicationController
	def new
		@current_photo = Photo.all.find_by id: params[:id]
		@all_users = User.all
		@tag = Tag.new
	end

	def create
		@tag = Tag.new
		@tag.photo_id = params[:photo_id]
		@tag.user_id = params[:tag][:user_id]
		@tag.width = params[:tag][:width]
		@tag.height = params[:tag][:height]
		@tag.x_coord = params[:tag][:x_coord]
		@tag.y_coord = params[:tag][:y_coord]

		if @tag.save() then
			flash[:notice] = "Tag added successfully! add another one? :)"
			redirect_to(:controller => 'tags', :action => 'new', :id => params[:photo_id])
		else
			flash[:alert] = "Please tag someone in the picture to submit a tag"
			redirect_to(:controller => 'tags', :action => 'new', :id => params[:photo_id])
		end
	end

end
