require 'rails_helper'

def basic_auth_pass(path)
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "メニュー新規登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @menu = FactoryBot.build(:menu)
  end

  context 'メニュー新規登録できる' do
    it '正しい情報を入力すれば新規登録できてトップページに登録したメニューが表示される' do
      # トップページに移動する
      basic_auth_pass root_path
      # ログイン画面に遷移することを確認する
      expect(current_path).to eq new_user_session_path
      # ユーザー情報を入力してログインする
      fill_in 'inputEmail', with: @user.email
      fill_in 'inputPassword', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新メニュー作成ページへのリンクがあることを確認する
      expect(page).to have_content('新メニュー作成（開発者用）')
      # 上記リンクをクリックすると新メニュー作成ページに移動する
      find_link('新メニュー作成（開発者用）', href: new_menu_path).click
      expect(current_path).to eq new_menu_path
      # フォームに情報を入力する
      fill_in 'menu_title', with: @menu.title
      fill_in 'menu_amount', with: @menu.amount
      fill_in 'menu_unit', with: @menu.unit
      fill_in 'menu_calorie', with: @menu.calorie
      fill_in 'menu_bar_code', with: @menu.bar_code
      attach_file('menu-image', Rails.root.join('public/images/test_image.jpg'))
      attach_file('menu-image-0', Rails.root.join('public/images/test_image.jpg'))
      attach_file('menu-image-1', Rails.root.join('public/images/test_image.jpg'))
      attach_file('menu-image-2', Rails.root.join('public/images/test_image.jpg'))
      attach_file('menu-image-3', Rails.root.join('public/images/test_image.jpg'))
      # 登録するボタンを押すと、Menuモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{ Menu.count }.by(1)
      # 登録完了ページに遷移することを確認する
      expect(current_path).to eq menus_path
      # 「メニューが新規登録されました」の文字があることを確認する
      expect(page).to have_content('メニューが新規登録されました')
      # トップページに遷移する
      visit root_path
      # トップページには先ほど登録した内容のメニューが存在することを確認する（画像）
      expect(page).to have_selector('img')
      # トップページには先ほど登録した内容のメニューが存在することを確認する（メニュー名）
      expect(page).to have_content(@menu.title)
    end
  end

  context 'メニュー新規登録できない' do
    it '誤った情報ではメニュー新規登録ができずにメニュー新規登録ページへ戻ってくる' do
      トップページに移動する
    end
  end
end
