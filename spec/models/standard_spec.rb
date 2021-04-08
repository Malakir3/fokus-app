require 'rails_helper'

RSpec.describe Standard, type: :model do
  describe '基準登録' do
    before do
      @standard = FactoryBot.build(:standard)
    end

    context '基準登録できるとき' do
      it 'large, medium, smallが存在し、userとmenuとに紐づいていれば登録できる' do
        expect(@standard).to be_valid
      end

      it 'largeが0より大きい数字ならば登録できる' do
        @standard.large = 1
        expect(@standard).to be_valid
      end

      it 'mediumが0より大きい数字ならば登録できる' do
        @standard.medium = 1
        expect(@standard).to be_valid
      end
      
      it 'smallが0より大きい数字ならば登録できる' do
        @standard.small = 1
        expect(@standard).to be_valid
      end
      
    end

    context '基準登録できないとき' do
      it 'largeが空では登録できない' do
        @standard.large = ''
        @standard.valid?
        expect(@standard.errors.full_messages).to include('大盛りを選択してください')
      end
      
      it 'mediumが空では登録できない' do
        @standard.medium = ''
        @standard.valid?
        expect(@standard.errors.full_messages).to include('普通を選択してください')
      end

      it 'smallが空では登録できない' do
        @standard.small = ''
        @standard.valid?
        expect(@standard.errors.full_messages).to include('小盛りを選択してください')
      end

      it 'largeに数字以外が含まれていれば登録できない' do
        @standard.large = '100g'
        @standard.valid?
        expect(@standard.errors.full_messages).to include('大盛りを選択してください')
      end

      it 'mediumに数字以外が含まれていれば登録できない' do
        @standard.medium = '100g'
        @standard.valid?
        expect(@standard.errors.full_messages).to include('普通を選択してください')
      end

      it 'smallに数字以外が含まれていれば登録できない' do
        @standard.small = '100g'
        @standard.valid?
        expect(@standard.errors.full_messages).to include('小盛りを選択してください')
      end

      it 'largeが0以下の数値では登録できない' do
        @standard.large = 0
        @standard.valid?
        expect(@standard.errors.full_messages).to include('大盛りを選択してください')
      end

      it 'mediumが0以下の数値では登録できない' do
        @standard.medium = 0
        @standard.valid?
        expect(@standard.errors.full_messages).to include('普通を選択してください')
      end

      it 'smallが0以下の数値では登録できない' do
        @standard.small = 0
        @standard.valid?
        expect(@standard.errors.full_messages).to include('小盛りを選択してください')
      end

      it 'userに紐づいていなければ登録できない' do
        @standard.user = nil
        @standard.valid?
        expect(@standard.errors.full_messages).to include('Userを入力してください')
      end

      it 'menuに紐づいていなければ登録できない' do
        @standard.menu = nil
        @standard.valid?
        expect(@standard.errors.full_messages).to include('Menuを入力してください')
      end
    end
  end
end
