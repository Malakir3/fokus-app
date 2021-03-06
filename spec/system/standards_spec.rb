require 'rails_helper'

RSpec.describe '基準登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @menu = FactoryBot.create(:menu)
  end

  context '基準登録できる' do
    it '正しい情報を入力すれば基準登録できる' do
      # トップページに移動してサインインする
      sign_in(@user)
      # 登録済みのメニュー画像をクリックするとメニュー詳細画面に遷移する
      find('img').click
      expect(current_path).to eq menu_path(@menu)
      # 基準登録ボタンがあることを確認する
      expect(page).to have_content('基準登録(推奨)')
      # 基準登録ボタンを押すと実績登録画面に遷移する
      find_link('基準登録(推奨)', href: new_menu_standard_path(@menu)).click
      expect(current_path).to eq new_menu_standard_path(@menu)
      # フォームに情報を入力する
      choose("standard_large_#{@menu.amount * 3}")
      choose("standard_medium_#{@menu.amount}")
      choose("standard_small_#{@menu.amount / 3}")
      # 登録するボタンを押すと、Standardモデルのカウントが1上がることを確認する
      expect do
        all('input[name="commit"]')[1].click
      end.to change { Standard.count }.by(1)
      # 登録完了ページに遷移することを確認する
      expect(current_path).to eq menu_standards_path(@menu)
      # 「"登録したメニュー名"の基準が新規登録されました」の文字があることを確認する
      expect(page).to have_content("#{@menu.title}の基準が新規登録されました")
      # 基準ページに移動する
      visit standards_path
      # 基準ページには基準登録したメニュー名、多め/普通/少なめの分量が存在することを確認する
      expect(page).to have_content(@menu.title.to_s)
      expect(page).to have_content((@menu.amount * 3).to_s)
      expect(page).to have_content(@menu.amount.to_s)
      expect(page).to have_content((@menu.amount / 3).to_s)
    end
  end

  context '基準登録できない' do
    it '誤った情報では基準登録できずに基準登録ページへ戻ってくる' do
      # トップページに移動してサインインする
      sign_in(@user)
      # 登録済みのメニュー画像をクリックするとメニュー詳細画面に遷移する
      find('img').click
      expect(current_path).to eq menu_path(@menu)
      # 基準登録ボタンがあることを確認する
      expect(page).to have_content('基準登録(推奨)')
      # 基準登録ボタンを押すと実績登録画面に遷移する
      find_link('基準登録(推奨)', href: new_menu_standard_path(@menu)).click
      expect(current_path).to eq new_menu_standard_path(@menu)
      # フォームの一部にのみ情報を入力する
      choose("standard_medium_#{@menu.amount}")
      # せずに登録するボタンを押すと、Standardモデルのカウントが変化しないことを確認する
      expect do
        all('input[name="commit"]')[1].click
      end.to change { Standard.count }.by(0)
      # 基準登録ページに戻されることを確認する
      expect(current_path).to eq menu_standards_path(@menu)
      # 「"登録したメニュー名"の基準が新規登録されました」の文字がないことを確認する
      expect(page).to have_no_content("#{@menu.title}の基準が新規登録されました")
      # 基準ページに移動する
      visit standards_path
      # トップページには先ほど登録した内容のメニューが存在しないことを確認する（画像）
      expect(page).to have_no_content(@menu.title.to_s)
      # トップページには先ほど登録した内容のメニューが存在しないことを確認する（メニュー名）
      expect(page).to have_no_content(@menu.amount.to_s)
    end
  end
end

RSpec.describe '基準編集', type: :system do
  before do
    @standard = FactoryBot.create(:standard)
  end

  context '基準を編集して登録できるとき' do
    it '編集後も必要な情報が入力されていれば登録できる' do
      # トップページに移動してサインインする
      sign_in(@standard.user)
      # 基準ページに移動する
      visit standards_path
      # 登録済みの基準について編集ページへのリンクがあることを確認する
      expect(page).to have_content('編集')
      # 上記リンクをクリックすると基準編集ページに遷移する
      find_link('編集', href: edit_menu_standard_path(@standard.menu, @standard)).click
      expect(current_path).to eq edit_menu_standard_path(@standard.menu, @standard)
      # 既に登録済みの内容が選択されていることを確認する
      expect(find_by_id("standard_large_#{@standard.large}")).to be_checked
      expect(find_by_id("standard_medium_#{@standard.medium}")).to be_checked
      expect(find_by_id("standard_small_#{@standard.small}")).to be_checked
      # 登録内容を編集する
      choose("standard_large_#{@standard.menu.amount * 2}")
      choose("standard_small_#{@standard.menu.amount / 2}")
      # 登録するボタンを押しても、Standardモデルのカウントが上がらないことを確認する
      expect do
        all('input[name="commit"]')[1].click
      end.to change { Menu.count }.by(0)
      # 編集完了ページに遷移することを確認する
      expect(current_path).to eq menu_standard_path(@standard.menu, @standard)
      # 「基準が更新されました」の文字があることを確認する
      expect(page).to have_content("#{@standard.menu.title}の基準が更新されました")
      # 基準ページに移動する
      visit standards_path
      # 基準ページには更新前の基準分量（普通）、先ほど更新した基準分量（多め/少なめ）が存在することを確認する
      expect(page).to have_content((@standard.menu.amount * 2).to_s)
      expect(page).to have_content(@standard.menu.amount.to_s)
      expect(page).to have_content((@standard.menu.amount / 2).to_s)
    end
  end

  context '基準を編集して登録できないとき' do
    it '基準を登録したユーザー以外はその基準を編集できない' do
      # 基準登録したユーザーとは別のユーザーを生成する
      another_user = FactoryBot.create(:user)
      # トップページに移動してanother_userでサインインする
      sign_in(another_user)
      # 基準ページに移動する
      visit standards_path
      # 基準ページには基準登録済みのメニュー名が存在しないことを確認する
      expect(page).to have_no_content(@standard.menu.title.to_s)
    end
  end
end

RSpec.describe '基準削除', type: :system do
  before do
    @standard = FactoryBot.create(:standard)
  end

  context '基準を削除できるとき' do
    it '削除ボタンが存在すれば削除できる' do
      # トップページに移動してサインインする
      sign_in(@standard.user)
      # 基準ページに移動する
      visit standards_path
      # 削除ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 削除ボタンを押すと、Standardモデルのカウントが1下がることを確認する
      expect do
        find_link('削除', href: menu_standard_path(@standard.menu, @standard)).click
      end.to change { Standard.count }.by(-1)
      # 削除完了ページに遷移することを確認する
      expect(current_path).to eq menu_standard_path(@standard.menu, @standard)
      # 「"メニュー名"の基準が削除されました」の文字があることを確認する
      expect(page).to have_content("#{@standard.menu.title}の基準が削除されました")
      # 基準ページに移動する
      visit standards_path
      # 基準ページには登録済みのメニュー名、分量（多め/普通/少なめ）が存在しないことを確認する
      expect(page).to have_no_content(@standard.menu.title)
    end
  end

  context '基準を削除できないとき' do
    it '基準を登録したユーザー以外はその基準を削除できない' do
      # 基準登録したユーザーとは別のユーザーを生成
      another_user = FactoryBot.create(:user)
      # トップページに移動してanother_userでサインインする
      sign_in(another_user)
      # 基準ページに移動する
      visit standards_path
      # 基準ページには基準登録済みのメニュー名が存在しないことを確認する
      expect(page).to have_no_content(@standard.menu.title.to_s)
    end
  end
end
