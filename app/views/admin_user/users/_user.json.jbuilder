json.extract! user, :id, :email, :approved, :first_name, :last_name, :created_at, :updated_at
json.url admin_user_user_url(user, format: :json)
