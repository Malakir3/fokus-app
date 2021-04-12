module SignInSupport
  def sign_in(user)
    basic_auth_pass root_path
    expect(current_path).to eq new_user_session_path
    fill_in 'inputEmail', with: user.email
    fill_in 'inputPassword', with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
  end
end
