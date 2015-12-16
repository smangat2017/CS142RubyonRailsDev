class CommentsController < ApplicationController
	def new
		@current_photo = Photo.all.find_by id: params[:id]
		@comment = Comment.new
	end

	def create
		@comment = Comment.new(photo_id: params[:photo_id], user_id: session[:userid], date_time: DateTime.now, comment: params[:comment][:comment]) 
		if @comment.save() then
			redirect_to(:controller => 'photos', :action => 'index', :id => params[:photo_user_id])
		else
			flash[:notice] = @comment.errors.messages
			redirect_to(:controller => 'comments', :action => 'new', :id => params[:photo_id])
		end
	end
end
