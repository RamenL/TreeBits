=begin
Filename: application_controller.rb
Description: This is the application controller. From here we perform most of our login and session checking to restrict the access to our pages.
=end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :login_required #checks to see that the user is logged in before every action is attempted
  before_action :org_create_required
  include SessionsHelper


=begin
Function: login_required
Parameters: none
Pre-Condition: called whenever an action in one of the controllers is called
Post-Condition: will redirect the user to the login page if they are not logged in.
=end
  def login_required
    if !logged_in?
	redirect_to login_path
    end
  end

=begin
  Require registered organization accounts to create an organization before they are able
  to navigate website.
  Pre-Condition: An organization user without an account
  Post-Condition: User placed on new organization page
=end
  def org_create_required
    if session[:user_type] == 1
        @org = Organization.exists?(session[:user_id])
        
        if !@org && request.path == new_opportunity_path
          redirect_to new_organization_path, flash: {notice: 'You are required to create an organization profile in order to create an event.'}

        end
    end
  end

=begin
Function: logged_in?
Parameters: none
Pre-Condition: application checks if the current user is logged in
Post-Condition: returns a true or false value whether the user is logged in
=end
  def logged_in?
    !!current_user
  end

  helper_method :logged_in?

=begin
Function: current_user
Parameters: none
Pre-Condition: logged_in? is called
Post-Condition: returns a boolean if the current session id is a valid user in the table
=end
  def current_user
    if session[:user_id]
        @current_user = User.find(session[:user_id])
	@current_user
    else
      false
    end
  end

  helper_method :current_user

end
