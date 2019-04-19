=begin
Filename: sessions_helper.rb
Description: this file provides helper methods that we use to implement sessions for the logged
in user
=end
module SessionsHelper

=begin
Function: log_in
Parameters: none
Pre-Condition: the user is successfully validated with the correct login
Post-Condition: generates a session for the user and sets their id, email, and access type
for the application to use.
=end
  def log_in(user)
    session[:user_id] = user.id
    session[:user_type] = user.user_type
    session[:user_email] = user.email
  end

=begin
Function: logged_in?
Parameters: none
Pre-Condition: the application needs to check to see that the user is logged in
Post-Condition: will return a true or false value to say if the current user is set or not.
=end
  def logged_in?
   !current_user.nil?
  end

=begin
Function: current_user
Parameters: none
Pre-Condition: none
Post-Condition: sets the current user only if it can find the user in the table
=end
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

=begin
Function: current_user
Parameters: none
Pre-Condition: someone needs to get the current users email
Post-condition: returns the id(email) from the session hash
=end
  def user_email
    session[:user_id]
  end

=begin
Function: log_out
Parameters: none
Pre-Condition: the user is logged int and selects the logout button
Post-Condition: the session will be cleared and the user will be effectively logged out
=end
  def log_out
    session.delete(:user_id)
    session.delete(:user_type)
    session.delete(:user_email)
    @current_user = nil
  end
end
