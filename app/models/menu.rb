class Menu < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :amount
    validates :unit
    validates :calorie
  end

  with_options numericality: { greater_than: 0 } do
    validates :amount
    validates :calorie
  end

  validates :bar_code, format: { with: /\A[0-9]+\z/, message: '0から9の数字のみを使って入力してください' }
end
