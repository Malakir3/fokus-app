require 'rails_helper'

RSpec.describe "基準登録", type: :system do
  before do
    @standard = FactoryBot.create(:standard)
  end

  context '基準登録できる' do
    it '正しい情報を入力すれば基準登録できる' do
      # トップページに移動してサインインする
      登録済みのメニュー画像をクリックするとメニュー詳細画面に遷移する
      

    end
  end

  context '基準登録できない' do
    it '誤った情報では基準登録できずに基準登録ページへ戻ってくる' do

    end
  end
end
