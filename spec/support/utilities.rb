def sign_up(user)
	fill_in("user[email]", with: "user@example.com")
	fill_in("user[phone_number]", with: "123456789")
	fill_in("user[password]", with: "foobarbaz")
	fill_in("user[password_confirmation]", with: "foobarbaz")
	fill_in("user[full_name]", with: "foobar")
	click_button  "Buat Akun"
end

def sign_in(user)
	visit new_user_session_path
	fill_in("user[login]", with: user.email)
	fill_in("user[password]", with: user.password)
	click_button  "Masuk"
end

def sign_out
	first(:link, "Keluar").click
end
