module ChurchAppsHelper
	def fullname(user_id)
		user = User.find(user_id)
		if user
			name = "#{user.first_name} #{user.last_name}"
			return name
		else
			name = ""
		end
	end

	def address_combine(church_id)
		church = ChurchApp.find(church_id)
		if church
			address = "#{church.address1}, #{church.address3}"
			return address
		else
			address = ""
		end
	end
end
