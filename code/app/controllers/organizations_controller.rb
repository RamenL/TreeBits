=begin
Filename: organizations_controller.rb
Description: this file is the controller class for the organization view page and all associated
interactions
=end
class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy], except: [:dashboard]

  # GET /organizations
  # GET /organizations.json
=begin
Function: index
Parameters: none
Pre-Condition: the user selects the organizations view from the toolbar
Post-Condition: a table of all organizations will be displayed to the user
=end
  def index
    @organizations = Organization.all
    @organizations = @organizations.sort_by &:name
  end

  # GET /organizations/1
  # GET /organizations/1.json
=begin
Function: show
Parameters: none
Pre-Condition: the user selects view for some organization in the view
Post-Condition: a page with all of the organizataions information will be displayed
=end
  def show
  end


=begin
Function: dashboard
Parameters: none
Pre-Condition: the user selects the organization dashboard view from the toolbar
Post-Condition: the user will be displayed all of the
=end
  def dashboard
    if session[:user_type].to_i == 1
      @organizations = Organization.where("email = ?", user_email)
      @organizations = @organizations.sort_by &:name

      @opportunities = Opportunity.where("email = ?", user_email)
      @opportunities = @opportunities.sort_by &:on_date
    elsif session[:user_type].to_i == 0
      @organizations = Organization.all
      @organizations = @organizations.sort_by &:name

      @opportunities = Opportunity.all
      @opportunities = @opportunities.sort_by &:on_date
    elsif session[:user_type].to_i == 2
      @favorites = FavoriteOpportunity.where("email = ?", user_email)
      @favorites = @favorites.sort_by(&:created_at).reverse
    end

  end

  # GET /organizations/new
=begin
Function: new
Parameters: none
Pre-Condition: the user attempts to create a new organization account
Post-Condition: the form for the organization information will be displayed to be filled out
=end
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
=begin
Function: edit
Parameters: none
Pre-Condition: the user selects the edit button next to their organization
Post-Condition: the user will be displayed the edit page to make changes
=end
  def edit
  end

  # POST /organizations
  # POST /organizations.json
=begin
Function: create
Parameters: none
Pre-Condition: the user must have filled out the org form and then click the create button
Post-Condition: the organizations information will be  in the table to the new information
=end
  def create
    p = organization_params
    p[:email] = user_email
    @organization = Organization.new(p)
    @organization.approved = FALSE
    respond_to do |format|
      if @organization.save
	format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
	format.json { render :show, status: :created, location: @organization }
      else
	format.html { render :new }
	format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
=begin
Function: update
Parameters: none
Pre-Condition: the user must have made some changes to the edit form and hit the update button
Post-Condition: the organizations information will be updated in the table
=end
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
=begin
Function: destroy
Parameters: none
Pre-Condition: the user clicked on the destory button next to the organization
Post-Condition: the organization will be removed from the table
=end
  def destroy

   #temp = @organization.email
    @organization.destroy
    #User.where("email = ?", temp).destroy_all
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:email, :name, :phone_no, :address, :city, :state, :zip_code, :description, :approved, :issue_area)
    end

end
