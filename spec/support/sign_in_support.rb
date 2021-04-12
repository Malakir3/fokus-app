module SignInSupport
  def basic_auth_pass(path)
    username = ENV["BASIC_AUTH_USER"] 
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end
  
  def sign_in(user)
    basic_auth_pass(root_path)
    expect(current_path).to eq new_user_session_path
    fill_in 'inputEmail', with: user.email
    fill_in 'inputPassword', with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
  end
end
