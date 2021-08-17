class AdminUsersController < ApplicationController
	
	layout 'admin'
	before_action :confirm_logged_in
	
	def index
		@admin_users = AdminUser.sorted
	end

	def new
		@admin_user = AdminUser.new
	end

	def create
		@admin_user = AdminUser.new(admin_user_params)
		if @admin_user.save
			flash[:notice] = "Admin User Created"
			redirect_to admin_users_path
		else
			render 'new'
		end
	end
	
	def edit
		@admin_user = AdminUser.find(params[:id])
	end

	def update
		@admin_user = AdminUser.find(params[:id])
		if @admin_user.update_attributes(admin_user_params)
			flash[:notice] = "Admin User Updated"
			redirect_to admin_users_path
		else
			render 'edit'
		end	
	end
	
	def delete
		@admin_user = AdminUser.find(params[:id])
	end

	def destroy
		@admin_user = AdminUser.find(params[:id])
		@admin_user.destroy
		flash[:notice] = "Admin User #{@admin_user.name} Deleted"
		redirect_to admin_users_path
	end

	private

	def admin_user_params
		params.require(:admin_user).permit(
			:first_name, 
			:last_name, 
			:username, 
			:email, 
			:password,
			:password_confirmation
		)
	end

end
