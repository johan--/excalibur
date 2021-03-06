def sign_up(user)
	fill_in("user[email]", with: "user@example.com")
	# fill_in("user[phone_number]", with: "123456789")
	fill_in("user[password]", with: "foobarbaz")
	fill_in("user[password_confirmation]", with: "foobarbaz")
	fill_in("user[full_name]", with: "foobar")
	click_button  "Buat Akun"
end

def sign_in(user)
	visit new_user_session_path
	fill_in("user[email]", with: user.email)
	fill_in("user[password]", with: user.password)
	click_button  "Masuk"
end

def sign_out
	first(:link, "Keluar").click
end

def login(user)
  post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
end

def file_upload_fixture
	Rails.root + "spec/support/markdown_cheatsheet.pdf"
end

def range_select(name, value)
  selector = %-input[type=range][name=\\"#{name}\\"]-
  # selector = %-input[type=text][name=\\"#{name}\\"]-
  script = %-$("#{selector}").val(#{value})-
  page.execute_script(script)
end