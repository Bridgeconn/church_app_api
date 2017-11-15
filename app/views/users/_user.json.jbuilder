json.extract! user, :id, :email, :approved, :first, :last, :created_at, :updated_at
json.url user_url(user, format: :json)
