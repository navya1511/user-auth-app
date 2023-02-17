class AccountController < ApplicationController
  def signup
    @user = User.new
    if request.post?
      @user = User.new(user_params)
      if @user.save
        UserNotifierMailer.signup_alert(@user).deliver
        redirect_to :action=>:login , notice: "Account Created Successfully"
      else
        render :action=>:signup
    end
  end
end

  def login
     if request.post?
      @user = User.authenticate(params[:email] , params[:password])
      if @user
        session[:user] = @user.id
        redirect_to :action=>:dashboard
      else
        flash[:notice] = "Invalid password"
        render :action=>:login
      end
    end
  end

  def logout
    session.delete(:user)
    redirect_to account_login_path
  end

  def dashboard
    @user = User.find(session[:user])
  end


  private
  def user_params
    params.require(:user).permit(:first_name , :last_name  ,:email, :phone, :date_of_birth , :password ,:password_confirmation, :encrypted_password )
  end

end
