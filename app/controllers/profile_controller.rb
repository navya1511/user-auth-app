class ProfileController < ApplicationController
  def edit_profile
    @user = User.find(session[:user])
    if request.post?
      
      if @user.update(profile_params)
        flash[:notice] = "Profile has been edited"
        redirect_to account_dashboard_path
      else
      flash[:notice] = "Invalid Credentials"
      render :action=>:edit_profile
    
  end
end
  end

  private
  def profile_params
    params.permit(:first_name , :last_name , :phone , :date_of_birth , :profile_picture)
  end
end
