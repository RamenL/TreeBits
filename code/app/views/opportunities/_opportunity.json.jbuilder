json.extract! opportunity, :opportunity_id, :name, :address, :city, :state, :zip_code, :transportation, :description, :frequency, :email, :created_at, :updated_at
json.url opportunity_url(opportunity, format: :json)
