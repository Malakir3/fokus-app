require 'rails_helper'

RSpec.describe Intake, type: :model do
  describe '実績登録' do
    before do
      @intake = FactoryBot.build(:intake)
    end

    context '実績登録できるとき' do
      it 'date, timing_id, value_idが存在し、userとmenuとに紐づいていれば登録できる' do
        expect(@intake).to be_valid
      end

      it 'timing_idが2から4の整数であれば登録できる' do
        @intake.timing_id = 4
        expect(@intake).to be_valid
      end

      it 'value_idが2から4の整数であれば登録できる' do
        @intake.value_id = 2
        expect(@intake).to be_valid
      end
    end

    context '実績登録できないとき' do
      it 'dateが空では登録できない' do
        @intake.date = ''
        @intake.valid?
        expect(@intake.errors.full_messages).to include('日付を入力してください')
      end

      it 'timing_idが空では登録できない' do
        @intake.timing_id = ''
        @intake.valid?
        expect(@intake.errors.full_messages).to include('タイミングを選択してください')
      end

      it 'value_idが空では登録できない' do
        @intake.value_id = ''
        @intake.valid?
        expect(@intake.errors.full_messages).to include('量を選択してください')
      end

      it 'timing_idが2から4の整数以外では登録できない' do
        @intake.timing_id = 1
        @intake.valid?
        expect(@intake.errors.full_messages).to include('タイミングを選択してください')
      end

      it 'value_idが2から4の整数以外では登録できない' do
        @intake.value_id = 1
        @intake.valid?
        expect(@intake.errors.full_messages).to include('量を選択してください')
      end
      
      it 'userに紐づいていなければ登録できない' do
        @intake.user = nil
        @intake.valid?
        expect(@intake.errors.full_messages).to include('Userを入力してください')
      end

      it 'menuに紐づいていなければ登録できない' do
        @intake.menu = nil
        @intake.valid?
        expect(@intake.errors.full_messages).to include('Menuを入力してください')
      end
    end
  end
end
