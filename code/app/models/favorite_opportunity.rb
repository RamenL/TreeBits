class FavoriteOpportunity < ApplicationRecord

  belongs_to :opportunity
  belongs_to :user, foreign_key: 'email'

  def get_opportunity(opportunity_id)
    Opportunity.find(opportunity_id)
  end

end
