=begin
Function: sessions_controller.rb
Description: this controller manages the session object used to restrict user access
throughout the application
=end
class SessionsController < ApplicationController
  #this line allows for certain actions to be called while not logged in
  before_action :login_required, :except => [:new, :create]

=begin
Function: new
Parameters: none
Pre-Condition: the user either clicks login or on a page while not logged in.
Post-Condition: the user will be directed to the login page
=end
  def new
  end

=begin
Function: create
Parameters: none
Pre-Condition: the user attempts to login
Post-Condition: if the user enters the correct information they will be logged in and
given a session, then redirected to some page depending on the account type. If they
enter incorrect information then they will not be logged in
=end
  def create
	user = User.find_by(email: params[:sessions][:email].downcase)
	if user && user.authenticate(params[:sessions][:password])
		#log the user in
		log_in user
		#need to conditionally redirect
		if session[:user_type].to_i == 2
			redirect_to opportunities_path 
		elsif session[:user_type].to_i == 1
			redirect_to opportunities_path
		elsif session[:user_type].to_i == 0
			redirect_to opportunities_path
		end

	else
		#create some error message
		flash.now[:danger] = 'Invalid email/password combination'
		render 'new'
	end
  end

=begin
Function: destroy
Parameters: none
Pre-Condition: the user must already be logged in and select the logout button
Post-Condition: the user will be logged out and their session destroyed. They will then be redirected to the root
=end
  def destroy
    log_out
    redirect_to root_url
  end
end
