=begin
Filename: users_controller.rb
Description: this controller manages the registration of a new user.
=end
class UsersController < ApplicationController
  #this allows for the user to register without needing to be logged in
  before_action :login_required, :except => [:new,:new_org, :create, :destroy]

=begin
Function: destroy
Delete user account
=end

def destroy
    temp = user_email
    @user.find(params[:email]).destroy
    flash[:success] = "User deleted"
    redirect_to dashboard_url
end

=begin
Function: show
This is not really used but would display the user info
=end
  def show
    @user = User.find_by(email: params[:email])
  end

=begin
Function: new
Parameters: none
Pre-Condition: the user selects on register student account option
Post-Condition: the user will be redirected to a registration page for students
=end
  def new
    @user = User.new
  end

=begin
Function: new_org
Parameters: none
Pre-Condition: the user selects on register organization account
Post-Condition: the user will be redirected to a refistration page for organizations
=end
  def new_org
    @user = User.new
  end

=begin
Function: create
Parameters: none
Pre-Condition: the user fills out the registration form and the user_type cannot be
set to an admin level.
Post-Condition: the user will be logged in and redirected according to their account type.
Organization will be directed to the form to fill out their information and the user will
=end
def create
  if user_params[:user_type].to_i != 0
    @user = User.new(user_params)
    if @user.save
      log_in @user

      if session[:user_type].to_i == 1
        redirect_to :controller=>'organizations', :action=>'new'
      else
        redirect_to opportunities_path
      end

    else
      if user_params[:user_type].to_i == 2
        render 'new'
      else
        render 'new_org'
      end
    end
  end
end

  private

    def user_params
      params.require(:user).permit(:email, :password,
                                   :password_confirmation, :user_type)
    end

end
