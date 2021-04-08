require 'rails_helper'

RSpec.describe Graph, type: :model do
  describe 'グラフデータ登録' do
    before do
      @graph = FactoryBot.build(:graph)
    end

    context 'グラフデータ登録できる' do
      it 'date, calorieがあれば登録できる' do
        expect(@graph).to be_valid
      end

      it 'calorieは0以上の数値であれば登録できる' do
        @graph.calorie = 1
        expect(@graph).to be_valid
      end
    end

    context 'グラフデータ登録できない' do
      it 'dateが空では登録できない' do
        @graph.date = ''
        @graph.valid?
        expect(@graph.errors.full_messages).to include('日付を入力してください')
      end

      it 'calorieが空では登録できない' do
        @graph.calorie = ''
        @graph.valid?
        expect(@graph.errors.full_messages).to include('カロリーを入力してください')
      end

      it 'calorieに数値以外が含まれていると登録できない' do
        @graph.calorie = '100kcal'
        @graph.valid?
        expect(@graph.errors.full_messages).to include('カロリーは数値で入力してください')
      end

      it 'calorieは0以下の数値では登録できない' do
        @graph.calorie = 0
        @graph.valid?
        expect(@graph.errors.full_messages).to include('カロリーは0より大きい値にしてください')
      end
    end
  end
end
