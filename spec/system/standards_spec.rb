require 'rails_helper'

# RSpec.describe "基準登録", type: :system do
#   before do
#     @user = FactoryBot.create(:user)
#     @menu = FactoryBot.create(:menu)
#   end

#   context '基準登録できる' do
#     it '正しい情報を入力すれば基準登録できる' do
#       # トップページに移動してサインインする
#       sign_in(@user)
#       # 登録済みのメニュー画像をクリックするとメニュー詳細画面に遷移する
#       find('img').click
#       expect(current_path).to eq menu_path(@menu)
#       # 基準登録ボタンがあることを確認する
#       expect(page).to have_content('基準登録(推奨)')
#       # 基準登録ボタンを押すと実績登録画面に遷移する
#       find_link('基準登録(推奨)', href: new_menu_standard_path(@menu)).click
#       expect(current_path).to eq new_menu_standard_path(@menu)
#       # フォームに情報を入力する
#       choose("standard_large_#{@menu.amount * 3}")
#       choose("standard_medium_#{@menu.amount}")
#       choose("standard_small_#{@menu.amount / 3}")
#       # 登録するボタンを押すと、Standardモデルのカウントが1上がることを確認する
#       expect{
#         find('input[name="commit"]').click
#       }.to change{ Standard.count }.by(1)
#       # 登録完了ページに遷移することを確認する
#       expect(current_path).to eq menu_standards_path(@menu)
#       # 「"登録したメニュー名"の基準が新規登録されました」の文字があることを確認する
#       expect(page).to have_content("#{@menu.title}の基準が新規登録されました")
#       # 基準一覧ページに移動する
#       visit standards_path
#       # 基準一覧ページには基準登録したメニュー名、大盛り/普通/小盛りの分量が存在することを確認する
#       expect(page).to have_content("#{@menu.title}")
#       expect(page).to have_content("#{@menu.amount * 3}")
#       expect(page).to have_content("#{@menu.amount}")
#       expect(page).to have_content("#{@menu.amount / 3}")
#     end
#   end

#   context '基準登録できない' do
#     it '誤った情報では基準登録できずに基準登録ページへ戻ってくる' do
#       # トップページに移動してサインインする
#       sign_in(@user)
#       # 登録済みのメニュー画像をクリックするとメニュー詳細画面に遷移する
#       find('img').click
#       expect(current_path).to eq menu_path(@menu)
#       # 基準登録ボタンがあることを確認する
#       expect(page).to have_content('基準登録(推奨)')
#       # 基準登録ボタンを押すと実績登録画面に遷移する
#       find_link('基準登録(推奨)', href: new_menu_standard_path(@menu)).click
#       expect(current_path).to eq new_menu_standard_path(@menu)
#       # フォームの一部にのみ情報を入力する
#       choose("standard_medium_#{@menu.amount}")
#       # せずに登録するボタンを押すと、Standardモデルのカウントが変化しないことを確認する
#       expect{
#         find('input[name="commit"]').click
#       }.to change{ Standard.count }.by(0)
#       # 基準登録ページに戻されることを確認する
#       expect(current_path).to eq menu_standards_path(@menu)
#       # 「"登録したメニュー名"の基準が新規登録されました」の文字がないことを確認する
#       expect(page).to have_no_content("#{@menu.title}の基準が新規登録されました")
#       # 基準一覧ページに移動する
#       visit standards_path
#       # トップページには先ほど登録した内容のメニューが存在しないことを確認する（画像）
#       expect(page).to have_no_content("#{@menu.title}")
#       # トップページには先ほど登録した内容のメニューが存在しないことを確認する（メニュー名）
#       expect(page).to have_no_content("#{@menu.amount}")
#     end
#   end
# end

RSpec.describe "基準編集", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @menu = FactoryBot.create(:menu)
  end
  
  context '基準を編集して再登録できるとき' do
    it '編集後も必要な情報が入力されていれば再登録できる' do
      # 基準登録する
      sign_in(@user)
      find('img').click
      expect(current_path).to eq menu_path(@menu)
      find_link('基準登録(推奨)', href: new_menu_standard_path(@menu)).click
      expect(current_path).to eq new_menu_standard_path(@menu)
      choose("standard_large_#{@menu.amount * 3}")
      choose("standard_medium_#{@menu.amount}")
      choose("standard_small_#{@menu.amount / 3}")
      expect{
        find('input[name="commit"]').click
      }.to change{ Standard.count }.by(1)
      expect(current_path).to eq menu_standards_path(@menu)
      # @standardの取得
      @standard = Standard.all[0]
      # 基準ページに移動する
      visit standards_path
      # 登録済みのメニュー名をクリックすると基準詳細画面に遷移する
      find_link("#{@menu.title}", href: menu_standard_path(@menu, @standard)).click
      expect(current_path).to eq menu_standard_path(@menu, @standard)
      # 登録済みの基準について編集ページへのリンクがあることを確認する
      expect(page).to have_content('編集')
      # 上記リンクをクリックすると基準編集ページに遷移する
      find_link('編集', href: edit_menu_standard_path(@menu, @standard)).click
      expect(current_path).to eq edit_menu_standard_path(@menu, @standard)
      # 既に登録済みの内容が選択されていることを確認する

      expect(page).to has_checked_field?("standard_large_#{@menu.amount * 3}")
      expect(
        find_by_id("standard_large_#{@menu.amount * 3}")
      ).to has_checked_field?

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
      # 登録するボタンを押しても、Standardモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{ Menu.count }.by(0)
      # 編集完了ページに遷移することを確認する
      expect(current_path).to eq menu_path(@menu)
      # 「基準が更新されました」の文字があることを確認する
      expect(page).to have_content("#{@menu.title}の基準が更新されました")
      # トップページに遷移する
      visit root_path
      # トップページには先ほど更新した基準の内容（大盛り/普通/小盛りの分量）が存在することを確認する（画像）
      expect(page).to have_selector('img')
    end
  end
end