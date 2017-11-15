module UsersHelper
	def fullname(id)
		user = User.find(id)
		if user
			name = "#{user.first_name} #{user.last_name}"
			return name
		else
			name = ""
		end
	end
end
