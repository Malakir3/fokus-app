require 'rails_helper'

RSpec.describe '実績登録', type: :system do
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
      expect do
        find('input[name="commit"]').click
      end.to change { Intake.count }.by(1)
      # 登録完了ページに遷移することを確認する
      expect(current_path).to eq menu_intakes_path(@standard.menu)
      # 「"登録したメニュー名"の食事実績が登録されました」の文字があることを確認する
      expect(page).to have_content("#{@standard.menu.title}の食事実績が登録されました")
      # 食事実績ページに移動する
      visit intakes_path
      # 食事実績ページには実績登録したメニュー名が存在することを確認する
      expect(page).to have_content(@standard.menu.title.to_s)
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
      expect do
        find('input[name="commit"]').click
      end.to change { Intake.count }.by(0)
      # 実績登録ページに戻されることを確認する
      expect(current_path).to eq menu_intakes_path(@standard.menu)
      # 「"登録したメニュー名"の食事実績が登録されました」の文字がないことを確認する
      expect(page).to have_no_content("#{@standard.menu.title}の食事実績が登録されました")
      # 食事実績ページに移動する
      visit intakes_path
      # 食事実績ページには実績登録したメニュー名が存在することを確認する
      expect(page).to have_no_content(@standard.menu.title.to_s)
    end
  end
end

RSpec.describe '実績編集', type: :system do
  before do
    @intake = FactoryBot.create(:intake)
  end

  context '実績編集できるとき' do
    it '正しい情報を入力すれば実績編集できる' do
      # トップページに移動してサインインする
      sign_in(@intake.user)
      # 食事実績ページに移動する
      visit intakes_path
      # 編集ボタンがあることを確認する
      expect(page).to have_content('編集')
      # 編集ボタンを押すと実績編集画面に遷移する
      find_link('編集', href: edit_menu_intake_path(@intake.menu, @intake)).click
      expect(current_path).to eq edit_menu_intake_path(@intake.menu, @intake)
      # 既に登録済みの内容が選択されていることを確認する
      expect(find_by_id('intake_date_1i').value).to eq(@intake.date.year.to_s)
      expect(find_by_id('intake_date_2i').value).to eq(@intake.date.month.to_s)
      expect(find_by_id('intake_date_3i').value).to eq(@intake.date.day.to_s)
      expect(find_by_id('intake_timing_id').value).to eq(@intake.timing_id.to_s)
      expect(find_by_id('intake_value_id').value).to eq(@intake.value_id.to_s)
      # フォームの情報を編集する
      select '2021', from: 'intake_date_1i'
      select '4月', from: 'intake_date_2i'
      select '20', from: 'intake_date_3i'
      select '夕食', from: 'intake_timing_id'
      select '多め', from: 'intake_value_id'
      # 編集するボタンを押しても、Intakeモデルのカウントが上がらないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Intake.count }.by(0)
      # 編集完了ページに遷移することを確認する
      expect(current_path).to eq menu_intake_path(@intake.menu, @intake)
      # 「"編集したメニュー名"の食事実績が更新されました」の文字があることを確認する
      expect(page).to have_content("#{@intake.menu.title}の食事実績が更新されました")
      # 食事実績ページに移動する
      visit intakes_path
      # 食事実績ページには実績編集したメニューの日付、時間帯、分量が存在することを確認する
      expect(page).to have_content('2021-04-20')
      expect(page).to have_content('夕食')
      expect(page).to have_content('多め')
    end
  end

  context '実績編集でないとき' do
    it '実績登録したユーザー以外はその基準を編集できない' do
      # 基準登録したユーザーとは別のユーザーを生成する
      another_user = FactoryBot.create(:user)
      # トップページに移動してanother_userでサインインする
      sign_in(another_user)
      # 食事実績ページに移動する
      visit intakes_path
      # 基準ページには基準登録済みのメニュー名と編集ボタンが存在しないことを確認する
      expect(page).to have_no_content(@intake.menu.title.to_s)
      expect(page).to have_no_link('編集', href: edit_menu_intake_path(@intake.menu, @intake))
    end
  end
end

RSpec.describe '実績削除', type: :system do
  before do
    @intake = FactoryBot.create(:intake)
  end

  context '実績削除できるとき' do
    it '実績登録したユーザーであれば実績削除できる' do
      # トップページに移動してサインインする
      sign_in(@intake.user)
      # 食事実績ページに移動する
      visit intakes_path
      # 削除ボタンがあることを確認する
      expect(page).to have_link('削除', href: menu_intake_path(@intake.menu, @intake))
      # 削除ボタンを押すと、Intakeモデルのカウントが1下がることを確認する
      expect do
        find_link('削除', href: menu_intake_path(@intake.menu, @intake)).click
      end.to change { Intake.count }.by(-1)
      # 削除完了ページに遷移することを確認する
      expect(current_path).to eq menu_intake_path(@intake.menu, @intake)
      # 「"削除したメニュー名"の食事実績が削除されました」の文字があることを確認する
      expect(page).to have_content("#{@intake.menu.title}の食事実績が削除されました")
      # 食事実績ページに移動する
      visit intakes_path
      # 食事実績ページには実績削除したメニュー名が存在しないことを確認する
      expect(page).to have_no_content(@intake.menu.title.to_s)
    end
  end

  context '実績削除できないとき' do
    it '実績登録したユーザー以外はその実績を削除できない' do
      # 実績登録したユーザーとは別のユーザーを生成する
      another_user = FactoryBot.create(:user)
      # トップページに移動してanother_userでサインインする
      sign_in(another_user)
      # 食事実績ページに移動する
      visit intakes_path
      # 実績ページには実績登録済みのメニュー名と削除ボタンが存在しないことを確認する
      expect(page).to have_no_content(@intake.menu.title.to_s)
      expect(page).to have_no_link('削除', href: menu_intake_path(@intake.menu, @intake))
    end
  end
end
