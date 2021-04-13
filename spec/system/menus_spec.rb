require 'rails_helper'

RSpec.describe "メニュー新規登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @menu = FactoryBot.build(:menu)
  end

  context 'メニュー新規登録できる' do
    it '正しい情報を入力すれば新規登録できてトップページに登録したメニューが表示される' do
      # トップページに移動してサインインする
      sign_in(@user)
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
      # トップページに移動してサインインする
      sign_in(@user)
      # 新メニュー作成ページへのリンクがあることを確認する
      expect(page).to have_content('新メニュー作成（開発者用）')
      # 上記リンクをクリックすると新メニュー作成ページに移動する
      find_link('新メニュー作成（開発者用）', href: new_menu_path).click
      expect(current_path).to eq new_menu_path
      # フォームに情報を入力する
      fill_in 'menu_title', with: ''
      fill_in 'menu_amount', with: ''
      fill_in 'menu_unit', with: ''
      fill_in 'menu_calorie', with: ''
      fill_in 'menu_bar_code', with: ''
      # 登録するボタンを押しても、Menuモデルのカウントが変化しないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{ Menu.count }.by(0)
      # メニュー新規登録ページに戻ってくることを確認する
      expect(current_path).to eq menus_path
      # トップページに遷移する
      visit root_path
      # トップページには先ほど登録した内容のメニューが存在しないことを確認する（画像）
      expect(page).to have_no_selector('img')
      # トップページには先ほど登録した内容のメニューが存在しないことを確認する（メニュー名）
      expect(page).to have_no_content(@menu.title)
    end
  end
end

RSpec.describe "メニュー編集", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @menu = FactoryBot.create(:menu)
  end
  
  context 'メニューを編集して再登録できるとき' do
    it '編集後も必要な情報が入力されていれば再登録できる' do
      # トップページに移動してサインインする
      sign_in(@user)
      # 登録済みのメニューについて編集ページへのリンクがあることを確認する
      expect(page).to have_content('編集')
      # 上記リンクをクリックするとメニュー編集ページに遷移する
      find_link('編集', href: edit_menu_path(@menu)).click
      expect(current_path).to eq edit_menu_path(@menu)
      # 既に登録済みの内容がフォームに入っていることを確認する
      expect(
        find_by_id('menu_title').value
      ).to eq(@menu.title)
      expect(
        find_by_id('menu_amount').value
      ).to eq(@menu.amount.to_s)
      expect(
        find_by_id('menu_unit').value
      ).to eq(@menu.unit)
      expect(
        find_by_id('menu_calorie').value
      ).to eq(@menu.calorie.to_s)
      expect(
        find_by_id('menu_bar_code').value
      ).to eq(@menu.bar_code)
      # 登録内容を編集する
      fill_in 'menu_title', with: "#{@menu.title}編集タイトル"
      fill_in 'menu_amount', with: @menu.amount + 100
      fill_in 'menu_unit', with: "#{@menu.unit}編集単位"
      fill_in 'menu_calorie', with: @menu.calorie + 100
      fill_in 'menu_bar_code', with: "#{@menu.bar_code}100"
      attach_file('menu-image', Rails.root.join('public/images/test_image2.jpg'))
      attach_file('menu-image-0', Rails.root.join('public/images/test_image2.jpg'))
      attach_file('menu-image-1', Rails.root.join('public/images/test_image2.jpg'))
      attach_file('menu-image-2', Rails.root.join('public/images/test_image2.jpg'))
      attach_file('menu-image-3', Rails.root.join('public/images/test_image2.jpg'))
      # 登録するボタンを押しても、Menuモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{ Menu.count }.by(0)
      # 編集完了ページに遷移することを確認する
      expect(current_path).to eq menu_path(@menu)
      # 「メニューが更新されました」の文字があることを確認する
      expect(page).to have_content('メニューが更新されました')
      # トップページに遷移する
      visit root_path
      # トップページには先ほど更新した内容のメニューが存在することを確認する（画像）
      expect(page).to have_selector('img')
      # トップページには先ほど変更した内容のメニューが存在することを確認する（メニュー名）
      expect(page).to have_content("#{@menu.title}" + "編集タイトル")
    end
  end

  context 'メニュー編集できないとき' do
    it '編集後に必要な情報が入力されていなければ再登録できない' do
      # トップページに移動してサインインする
      sign_in(@user)
      # 登録済みのメニューについて編集ページへのリンクがあることを確認する
      expect(page).to have_content('編集')
      # 上記リンクをクリックするとメニュー編集ページに遷移する
      find_link('編集', href: edit_menu_path(@menu)).click
      expect(current_path).to eq edit_menu_path(@menu)
      # 既に登録済みの内容がフォームに入っていることを確認する
      expect(
        find_by_id('menu_title').value
      ).to eq(@menu.title)
      # 登録内容の一部が空欄になるように編集する
      fill_in 'menu_title', with: "#{@menu.title}編集タイトル"
      fill_in 'menu_amount', with: ''
      # 登録するボタンを押しても、Menuモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{ Menu.count }.by(0)
      # 編集ページに戻されることを確認する
      expect(current_path).to eq menu_path(@menu)
      # 「メニューが更新されました」の文字がないことを確認する
      expect(page).to have_no_content('メニューが更新されました')
      # トップページに遷移する
      visit root_path
      # トップページには登録済みのメニューの内容が存在することを確認する（メニュー名）
      expect(page).to have_content(@menu.title)
      # トップページには先ほど変更しようとしたメニューの内容が存在しないことを確認する（メニュー名）
      expect(page).to have_no_content("#{@menu.title}編集タイトル")
    end
  end
end

RSpec.describe "メニュー削除", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @menu = FactoryBot.create(:menu)
  end

  context 'メニューを削除できるとき' do
    it '削除ボタンが存在すれば削除できる' do
      # トップページに移動してサインインする
      sign_in(@user)
      # 登録済みのメニュー画像をクリックするとメニュー詳細画面に遷移する
      find('img').click
      expect(current_path).to eq menu_path(@menu)
      # 削除ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 削除ボタンを押すと、Menuモデルのカウントが1下がることを確認する
      expect{
        find_link('削除', href: menu_path(@menu)).click
      }.to change{ Menu.count }.by(-1)
      # 削除完了ページに遷移することを確認する
      expect(current_path).to eq menu_path(@menu)
      # 「メニューが削除されました」の文字があることを確認する
      expect(page).to have_content('メニューが削除されました')
      # トップページに移動する
      visit root_path
      # トップページには登録済みのメニューが存在しないことを確認する（画像）
      expect(page).to have_no_selector('img')
      # トップページには登録済みのメニューが存在しないことを確認する（メニュー名）
      expect(page).to have_no_content(@menu.title)
    end
  end
end