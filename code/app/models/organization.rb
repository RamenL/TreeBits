=begin
  Class: Organization

  Functions:
    self.login?(email, password)
    self.from_email(email)
    self.register(email, password, name, phone_no, address, city, state, zip_code, description)
    self.search_by_city(cities)
    self.search_by_state(states)
    self.search_by_category(categories)
    set_name(new_name)
    set_phone_no(new_phone)
    set_address(new_address)
    set_city(new_city)
    set_state(new_state)
    set_zip_code(new_zip_code)
    set_description(new_description)
    set_approved(email, approval)
    add_category(category)
    remove_category(category)
    get_categories()
    add_opportunity(name, address, city, state, zip_code, transportation, description, frequency)
    remove_opportunity(id)
    get_opportunities()
=end

class Organization < ApplicationRecord
  self.table_name = 'organization'

  validates :name, :email, :phone_no, presence: true
 
  #Start of Edit 
 
  has_many :opportunities
  has_many :favorite_opportunities
  has_many :favorites, through: :favorite_opportunities, source: :opportunity
  #End of Edit
 
=begin
 Function: self.login?()

 Parameters:
  String: input email
  String: input password

 Post-condition:
  return boolean: whether email and password match an organization account
=end
  def self.login?(email, password)
    User.exists?(email: email, password: password) && Organization.exists?(email: email, approved: true)
  end

=begin
 Function: self.from_email()

 Parameters:
  String: key of the organization account to find

 Post-condition:
  return Organization: model of the organization account to find
=end
  def self.from_email(email)
    Organization.find(email)
  end

=begin
 Function: self.register()

 Parameters:
  String: email of the new organization account
  String: password of the new organization account

 Post-condition:
  if account has not already been made, add new account
    to user and organization tables
=end
  def self.register(email,
                    password,
                    name,
                    phone_no,
                    address,
                    city,
                    state,
                    zip_code,
                    description)
    if !User.exists?(email: email)
      User.create(email: email,
                  password: password,
                  user_type: 1)
      Organization.create(email: email,
                          name: name,
                          phone_no: phone_no,
                          address: address,
                          city: city,
                          state: state,
                          zip_code: zip_code,
                          description: description,
                          approved: false)
    end
  end

=begin
 Function: self.search_by_city()

 Parameters:
  Array: cities chosen to filter by

 Post-condition:
  return Relation: set of keys for the organizations matching search
=end
  def self.search_by_city(cities)
    Organization.where("city = ?", cities).select("email")
  end

=begin
 Function: self.search_by_state()

 Parameters:
  Array: states chosen to filter by

 Post-condition:
  return Relation: set of keys for the organizations matching search
=end
  def self.search_by_state(states)
    Organization.where("state = ?", states).select("email")
  end

=begin
 Function: self.search_by_category()

 Parameters:
  Array: categories chosen to filter by

 Post-condition:
  return Relation: set of keys for the organizations matching search
=end
  def self.search_by_category(categories)
    OrganizationCategory.where("category = ?", categories).select("email")
  end

=begin
 Function: set_name()

 Parameters:
  String: new name for the organization

 Post-condition:
  update name for the organization
=end
  def set_name(new_name)
    update(name: new_name)
  end

=begin
 Function: set_phone_no()

 Parameters:
  String: new phone number for the organization

 Post-condition:
  update phone number for the organization
=end
  def set_phone_no(new_phone)
    update(phone_no: new_phone)
  end

=begin
 Function: set_address()

 Parameters:
  String: new street address for the organization

 Post-condition:
  update street address for the organization
=end
  def set_address(new_address)
    update(address: new_address)
  end

=begin
 Function: set_city()

 Parameters:
  String: new city for the organization

 Post-condition:
  update city for the organization
=end
  def set_city(new_city)
    update(city: new_city)
  end

=begin
 Function: set_state()

 Parameters:
  String: new state for the organization

 Post-condition:
  update state for the organization
=end
  def set_state(new_state)
    update(state: new_state)
  end

=begin
 Function: set_zip_code()

 Parameters:
  String: new zip code for the organization

 Post-condition:
  update zip code for the organization
=end
  def set_zip_code(new_zip_code)
    update(zip_code: new_zip_code)
  end

=begin
 Function: set_description()

 Parameters:
  String: new description for the organization

 Post-condition:
  update description for the organization
=end
  def set_description(new_description)
    update(description: new_description)
  end

=begin
 Function: set_approved()

 Parameters:
  String: key of organization to approve/disapprove
  boolean: whether the organization should be approved or not

 Post-condition:
  if account is CELR, update approval for given organization
=end
  def set_approved(email, approval)
    if User.find(email).Type == 0
      Organization.find(email).update(approved: approval)
    end
  end

  def get_event_approval(opportunity)
    Organization.find(opportunity.email).approved
  end

  def get_org_approval(organization)
    organization.approved
  end

=begin
 Function: add_category()

 Parameters:
  String: category to add

 Post-condition:
  add category to categories table for the organization
=end
  def add_category(category)
    OrganizationCategory.create(email: email, category: category)
  end

=begin
 Function: remove_category()

 Parameters:
  String: category to remove

 Post-condition:
  remove category from categories table for the organization
=end
  def remove_category(category)
    OrganizationCategory.find_by(email: email, category: category).destroy
  end

=begin
 Function: get_categories()

 Parameters:

 Post-condition:
  return Relation: set of categories for the organization
=end
  def get_categories
    OrganizationCategory.where("email = ?", email).all
  end

=begin
 Function: add_opportunity()

 Parameters:
  String: name of opportunity to add
  String: street address of opportunity to add
  String: city of opportunity to add
  String: state of opportunity to add
  String: zip code of opportunity to add
  boolean: whether transportation is provided
  String: description of opportunity to add
  String: frequency of opportunity to add

 Post-condition:
  add opportunity to opportunity table for the organization
=end
  def add_opportunity(name,
                      address,
                      city,
                      state,
                      zip_code,
                      transportation,
                      description,
                      frequency)
      Opportunity.create(name: name,
                          address: address,
                          city: city,
                          state: state,
                          zip_code: zip_code,
                          transportation: transportation,
                          description: description,
                          frequency: frequency,
                          email: email)
  end

=begin
 Function: remove_opportunity()

 Parameters:
  integer: key of opportunity to remove

 Post-condition:
  if account is CELR or the organization is owner of the opportunity,
    remove opportunity from opportunity table for the organization
=end
  def remove_opportunity(id)
    if User.find(email).Type == 0 || Opportunity.find(id).email.equal?(email)
      Opportunity.find(id).destroy
    end
  end

=begin
 Function: get_opportunities()

 Parameters:

 Post-condition:
  return Relation: set of opportunities for the organization
=end
  def get_opportunities
    Opportunity.where("email = ?", email).all
  end

  def get_issue_area(email)
    category = OrganizationCategory.where("email = ?", email).first
    category.issue_area
  end

end
