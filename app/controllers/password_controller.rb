class PasswordController < ApplicationController
  def forgot_password
    if request.post?
      @user = User.find_by_email(params[:email])
      if @user
        new_password = create_random_password
        @user.update(:password=>new_password)
        UserNotifierMailer.send_password(@user).deliver
        redirect_to account_login_path
      else
        flash[:notice] = "Invalid Email"
        redirect_to password_forgot_password_path
      end
    end
  end

  def create_random_password
    (0..6).map{(65 + rand(26)).chr}.join
  end
  
  def reset_password
    if request.post?
      @user = User.find(session[:user])
      if @user
        if @user.update(user_params)
          flash[:notice] = "password has been Reset"
         UserNotifierMailer.reset_password(@user).deliver
         redirect_to account_dashboard_path
      else
        flash[:notice] = "Invalid email"
        render :action=>:reset_password
      end
    end
  end
end

def user_params
  params.permit(:password , :password_confirmation)
end


end
