require 'rails_helper'

def basic_auth_pass(path)
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録できるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      basic_auth_pass root_path
      # トップページに新規登録ページに遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_lastname', with: @user.lastname
      fill_in 'user_firstname', with: @user.firstname
      select '2020', from: 'user_birthday_1i'
      select '1月', from: 'user_birthday_2i'
      select '30', from: 'user_birthday_3i'
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # 新規登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ移動したことを確認する
      expect(current_path).to eq(root_path)
      # 新規登録ページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録できないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      # トップページに新規登録ページに遷移するボタンがあることを確認する
      # 新規登録ページへ移動する
      # ユーザー情報を入力する
      # 新規登録ボタンを押してもユーザーモデルのカウントが上がらないことを確認する
      # 新規登録ページへ戻されることを確認する
    end
  end
  

end
