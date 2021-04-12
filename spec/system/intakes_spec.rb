require 'rails_helper'

RSpec.describe "実績登録", type: :system do
  before do
    @standard = FactoryBot.create(:standard)
  end

  context '実績登録できるとき' do
    it '正しい情報を入力すれば実績登録できる' do
      # トップページに移動してサインインする
      sign_in(@standard.user)
      # 登録済みのメニュー画像をクリックするとメニュー詳細画面に遷移する
      find('img').click
      expect(current_path).to eq menu_path(@standard.menu)
      # 実績登録ボタンがあることを確認する
      expect(page).to have_content('実績登録')
      # 実績登録ボタンを押すと実績登録画面に遷移する
      find_link('実績登録', href: new_menu_intake_path(@standard.menu)).click
      expect(current_path).to eq new_menu_intake_path(@standard.menu)
      # フォームに情報を入力する
      select '2021', from: 'intake_date_1i'
      select '3月', from: 'intake_date_2i'
      select '10', from: 'intake_date_3i'
      select '朝食', from: 'intake_timing_id'
      select '普通', from: 'intake_value_id'
      # 登録するボタンを押すと、Intakeモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{ Intake.count }.by(1)
      # 登録完了ページに遷移することを確認する
      expect(current_path).to eq menu_intakes_path(@standard.menu)
      # 「"登録したメニュー名"の食事実績が登録されました」の文字があることを確認する
      expect(page).to have_content("#{@standard.menu.title}の食事実績が登録されました")
      # 食事履歴一覧ページに移動する
      visit intakes_path
      # 食事履歴一覧ページには実績登録したメニュー名が存在することを確認する
      expect(page).to have_content("#{@standard.menu.title}")
      # グラフ作成ボタンを押すと、グラフが表示され、「グラフ作成ボタンを押してください」の表示が消える
      expect(page).to have_content('グラフ作成ボタンを押してください')
      find_link('グラフ作成', href: graphs_path).click
      expect(page).to have_no_content('グラフ作成ボタンを押してください')
    end
  end

  context '実績登録できないとき' do
    it '誤った情報では実績登録できずに実績登録ページへ戻ってくる' do
      # トップページに移動してサインインする
      sign_in(@standard.user)
      # 登録済みのメニュー画像をクリックするとメニュー詳細画面に遷移する
      find('img').click
      expect(current_path).to eq menu_path(@standard.menu)
      # 実績登録ボタンがあることを確認する
      expect(page).to have_content('実績登録')
      # 実績登録ボタンを押すと実績登録画面に遷移する
      find_link('実績登録', href: new_menu_intake_path(@standard.menu)).click
      expect(current_path).to eq new_menu_intake_path(@standard.menu)
      # フォームの一部にのみ情報を入力する
      select '2021', from: 'intake_date_1i'
      select '3月', from: 'intake_date_2i'
      select '10', from: 'intake_date_3i'
      # 登録するボタンを押しても、Intakeモデルのカウントが変化しないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{ Intake.count }.by(0)
      # 実績登録ページに戻されることを確認する
      expect(current_path).to eq menu_intakes_path(@standard.menu)
      # 「"登録したメニュー名"の食事実績が登録されました」の文字がないことを確認する
      expect(page).to have_no_content("#{@standard.menu.title}の食事実績が登録されました")
      # 食事履歴一覧ページに移動する
      visit intakes_path
      # 食事履歴一覧ページには実績登録したメニュー名が存在することを確認する
      expect(page).to have_no_content("#{@standard.menu.title}")
    end
  end
end
