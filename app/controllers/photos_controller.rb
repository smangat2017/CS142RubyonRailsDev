class PhotosController < ApplicationController
	def index
		id = params[:id]
		@user = User.find_by id: id
		if @user !=nil
			@photos = @user.photos
		end
	end

	def new
		@photo = Photo.new
	end

	def create
		uploaded_io = params[:photo][:photo]
 		File.open(Rails.root.join('app', 'assets', 'images', uploaded_io.original_filename), 'wb') do |file|
    	file.write(uploaded_io.read)
    	end

    	@photo = Photo.new(user_id: session[:userid], date_time: DateTime.now, file_name: uploaded_io.original_filename) 
		if @photo.save() then
			redirect_to(:controller => 'photos', :action => 'index', :id => session[:userid])
		else
			flash[:notice] = @photo.errors.messages
			redirect_to(:controller => 'comments', :action => 'new', :id => params[:photo_id])
		end
	end

end
