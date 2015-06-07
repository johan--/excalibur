module RostersHelper

	def role_translated(role)
		return "Pemilik" if role == 0
		return "Pengelola" if role == 1
		return "Staff" if role == 2
	end

end