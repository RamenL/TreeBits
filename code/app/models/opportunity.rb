=begin
  Class: Opportunity

  Functions:
    self.from_id(opportunity_id)
    self.search_by_city(cities)
    self.search_by_state(states)
    self.search_by_category(categories)
    self.search_by_transportation(hasTransportation)
    self.search_by_frequency(frequencies)
    self.search_by_category(categories)
    self.search_by_skill(skills)
    self.search_by_date(dates)
    set_name(new_name)
    set_address(new_address)
    set_city(new_city)
    set_state(new_state)
    set_zip_code(new_zip_code)
    set_transportation(transportation)
    set_description(new_description)
    set_frequency(frequency)
    set_datetime(old_date, new_date, time)
    add_category(category)
    remove_category(category)
    get_categories()
    add_skill(skill)
    remove_skill(skill)
    get_skills()
    add_form(path)
    remove_form(path)
    get_forms()
=end

class Opportunity < ApplicationRecord
  self.table_name = 'opportunity'

  has_many :forms
  has_many :event_dates
  has_many :opportunity_categories

  #Start of Edit
  #belongs_to :organization

  has_many :favorite_opportunities
  has_many :favorited_by, through: :favorite_opportunitites, source: :user
  #End of Edit


  validates :name, :address, :city, :state, :zip_code, :description, :email, presence: true
  validates :zip_code, numericality: { only_integer: true }
 
  validate :check_times
  validates_uniqueness_of :name, scope: :email
  
=begin
 Function: self.from_id()

 Parameters:
  integer: key of the organization account to find

 Post-condition:
  return Opportunity: model of the opportunity to find
=end
  def self.from_id(opportunity_id)
    Opportunity.find(opportunity_id)
  end

=begin
 Function: self.check()
 Checks that start time is before end time of events
=end

 def check_times
   if start_time >= end_time
     errors.add(:end_time, "must be after Start time")
   end 
 end


=begin
 Function: self.search_by_city()

 Parameters:
  Array: cities chosen to filter by

 Post-condition:
  return Relation: set of keys for opportunities matching search
=end
  def self.search_by_city(cities)
    Opportunity.where("city = ?", cities).select("opportunity_id")
  end

=begin
 Function: self.search_by_state()

 Parameters:
  Array: states chosen to filter by

 Post-condition:
  return Relation: set of keys for opportunities matching search
=end
  def self.search_by_state(states)
    Opportunity.where("state = ?", states).select("opportunity_id")
  end

=begin
 Function: self.earch_by_state()

 Parameters:
  boolean: whether transportation is provided

 Post-condition:
  return Relation: set of keys for opportunities matching search
=end
  def self.search_by_transportation(hasTransportation)
    Opportunity.where("transportation = ?", hasTransportation).select("opportunity_id")
  end

=begin
 Function: self.search_by_frequency()

 Parameters:
  Array: types of frequency chosen to filter by

 Post-condition:
  return Relation: set of keys for opportunities matching search
=end
  def self.search_by_frequency(frequencies)
    matches = Array.new
    for frequency in frequencies do
      matches.push(Opportunity.where("frequency = ?", frequency).select("opportunity_id"))
    end
    return matches
  end

=begin
 Function: self.search_by_category()

 Parameters:
  Array: categories chosen to filter by

 Post-condition:
  return Relation: set of keys for opportunities matching search
=end
  def self.search_by_category(categories)
    matches = Array.new
    for category in categories do
      matches.push(OpportunityCategory.where("category = ?", category).select("opportunity_id"))
    end
    return matches
  end

=begin
 Function: self.search_by_skill()

 Parameters:
  Array: skills chosen to filter by

 Post-condition:
  return Relation: set of keys for opportunities matching search
=end
  def self.search_by_skill(skills)
    matches = Array.new
    for skill in skills do
      matches.push(Skill.where("skill = ?", skill).select("opportunity_id"))
    end
    return matches
  end

=begin
 Function: self.search_by_date()

 Parameters:
  Array: dates chosen to filter by

 Post-condition:
  return Relation: set of keys for opportunities matching search
=end
  def self.search_by_date(dates)
    EventDate.where("on_date = ?", dates).select("opportunity_id")
  end

=begin
 Function: set_name()

 Parameters:
  String: new name for the opportunity

 Post-condition:
  update name for the opportunity
=end
  def set_name(new_name)
    update(name: new_name)
  end

=begin
 Function: set_address()

 Parameters:
  String: new street address for the opportunity

 Post-condition:
  update street address for the opportunity
=end
  def set_address(new_address)
    update(address: new_address)
  end

=begin
 Function: set_city()

 Parameters:
  String: new city for the opportunity

 Post-condition:
  update city for the opportunity
=end
  def set_city(new_city)
    update(city: new_city)
  end

=begin
 Function: set_state()

 Parameters:
  String: new state for the opportunity

 Post-condition:
  update state for the opportunity
=end
  def set_state(new_state)
    update(state: new_state)
  end

=begin
 Function: set_zip_code()

 Parameters:
  String: new zip code for the opportunity

 Post-condition:
  update zip code for the opportunity
=end
  def set_zip_code(new_zip_code)
    update(zip_code: new_zip_code)
  end

=begin
 Function: set_transportation()

 Parameters:
  boolean: whether transportation is provided for the opportunity

 Post-condition:
  update transportation for the opportunity
=end
  def set_transportation(transportation)
    update(transportation: transportation)
  end

=begin
 Function: set_description()

 Parameters:
  String: new description for the opportunity

 Post-condition:
  update description for the opportunity
=end
  def set_description(new_description)
    update(description: new_description)
  end

=begin
 Function: set_frequency()

 Parameters:
  String: new frequency for the opportunity

 Post-condition:
  update frequency for the opportunity
=end
  def set_frequency(frequency)
    update(frequency: frequency)
  end

=begin
 Function: set_datetime()

 Parameters:
  String: new date/time for the opportunity

 Post-condition:
  update date/time for the opportunity
=end
  def set_datetime(old_date, new_date, time)
    EventDate.find_by(opportunity_id: opportunity_id, on_date: old_date).update(on_date: new_date, time: time)
  end

=begin
 Function: add_category()

 Parameters:
  String: category to add

 Post-condition:
  add category to categories table for the opportunity
=end
  def add_category(category)
    OpportunityCategory.create(opportunity_id: opportunity_id, category: category)
  end

=begin
 Function: remove_category()

 Parameters:
  String: category to remove

 Post-condition:
  remove category from categories table for the opportunity
=end
  def remove_category(category)
    OpportunityCategory.find_by(id: opportunity_id, category: category).destroy
  end

=begin
 Function: get_categories()

 Parameters:

 Post-condition:
  return Relation: set of categories for the opportunity
=end
  def get_categories
    OpportunityCategory.where("opportunity_id = ?", opportunity_id).all
  end

=begin
 Function: add_skill()

 Parameters:
  String: skill to add

 Post-condition:
  add skill to skills required for the opportunity
=end
  def add_skill(skill)
    Skill.create(id: opportunity_id, skill: skill)
  end

=begin
 Function: remove_skill()

 Parameters:
  String: skill to remove

 Post-condition:
  remove skill from skills required for the opportunity
=end
  def remove_skill(skill)
    Skill.find_by(id: opportunity_id, skill: skill).destroy
  end

=begin
 Function: get_skills()

 Parameters:

 Post-condition:
  return Relation: set of skills required for the opportunity
=end
  def get_skills
    Skill.where("opportunity_id = ?", opportunity_id).all
  end

=begin
  def get_bookmark
    Bookmark.where("opportunity_id =?", opportunity_id).first
  end
=end

=begin
 Function: add_form()

 Parameters:
  String: path to required form to remove

 Post-condition:
  add form to forms required for the opportunity
=end
  def add_form(path)
    Form.create(opportunity_id: opportunity_id, link_path: path)
  end

=begin
 Function: remove_form()

 Parameters:
  String: path to required form to remove

 Post-condition:
  remove form from forms required for the opportunity
=end
  def remove_form(path)
    Form.find_by(opportunity_id: opportunity_id, link_path: path).destroy
  end

=begin
 Function: get_forms()

 Parameters:

 Post-condition:
  return Relation: set of forms required for the opportunity
=end
  def get_forms
    Form.where("opportunity_id = ?", opportunity_id).all
  end

  def get_organization_name(email)
    Organization.find(email).name
  end

  def get_approval(opportunity)
    Organization.find(opportunity.email).get_event_approval(opportunity)
  end

  def in_favorites?(email)
    FavoriteOpportunity.exists?(email: email, opportunity_id: opportunity_id)
  end

  def get_date(opportunity_id)
    date = EventDate.where("opportunity_id = ?", opportunity_id).first
    date.on_date
  end

  def get_start_time(opportunity_id)
    start_time = EventDate.where("opportunity_id = ?", opportunity_id).first
    start_time.start_time
  end

  def get_end_time(opportunity_id)
    end_time = EventDate.where("opportunity_id = ?", opportunity_id).first
    end_time.end_time
  end

  def get_issue_area(opportunity_id)
    category = OpportunityCategory.where("opportunity_id = ?", opportunity_id).first
    category.issue_area
  end

end
