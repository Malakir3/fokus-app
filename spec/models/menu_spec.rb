require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'メニュー登録' do
    before do
      @menu = FactoryBot.build(:menu)
    end

    context 'メニュー登録できるとき' do
      it 'title, amount, unit, calorie, bar_code, imagesが存在すれば登録できる' do
        expect(@menu).to be_valid
      end

      it 'amountは0より大きな数字であれば登録できる' do
        @menu.amount = 1
        expect(@menu).to be_valid
      end

      it 'calorieは0より大きな数字であれば登録できる' do
        @menu.calorie = 1
        expect(@menu).to be_valid
      end

      it 'bar_codeがなくても登録できる' do
        @menu.bar_code = ''
        expect(@menu).to be_valid
      end

      it 'bar_codeは0から9の数字のみが使用されていれば登録できる' do
        @menu.bar_code = '0123456789'
        expect(@menu).to be_valid
      end
    end

    context 'メニュー登録できないとき' do
      it 'titleが空では登録できない' do
        @menu.title = ''
        @menu.valid?
        expect(@menu.errors.full_messages).to include('メニュー名を入力してください')
      end

      it 'amountが空では登録できない' do
        @menu.amount = ''
        @menu.valid?
        expect(@menu.errors.full_messages).to include('分量を入力してください')
      end

      it 'amountに0から9の数字以外が含まれていれば登録できない' do
        @menu.amount = '10g'
        @menu.valid?
        expect(@menu.errors.full_messages).to include('分量は数値で入力してください')
      end

      it 'amountは0以下の値では登録できない' do
        @menu.amount = 0
        @menu.valid?
        expect(@menu.errors.full_messages).to include('分量は0より大きい値にしてください')
      end

      it 'unitが空では登録できない' do
        @menu.unit = ''
        @menu.valid?
        expect(@menu.errors.full_messages).to include('単位を入力してください')
      end

      it 'calorieが空では登録できない' do
        @menu.calorie = ''
        @menu.valid?
        expect(@menu.errors.full_messages).to include('カロリーを入力してください')
      end

      it 'calorieに0から9の数字以外が含まれていれば登録できない' do
        @menu.calorie = '10kcal'
        @menu.valid?
        expect(@menu.errors.full_messages).to include('カロリーは数値で入力してください')
      end

      it 'calorieは0以下の値では登録できない' do
        @menu.calorie = 0
        @menu.valid?
        expect(@menu.errors.full_messages).to include('カロリーは0より大きい値にしてください')
      end

      it 'imagesが空では登録できない' do
        @menu.images = nil
        @menu.valid?
        expect(@menu.errors.full_messages).to include('画像を添付してください')
      end

      it 'bar_codeに0から9の数字以外が含まれていれば登録できない' do
        @menu.bar_code = '012-3456789'
        @menu.valid?
        expect(@menu.errors.full_messages).to include('バーコードは0から9の数字のみで入力してください')
      end
    end
  end
end
