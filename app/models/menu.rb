class Menu < ApplicationRecord
  has_many :standards, dependent: :destroy
  has_many :intakes, dependent: :destroy
  has_many_attached :images

  with_options presence: true do
    validates :title
    validates :amount
    validates :unit
    validates :calorie
    validates :images, presence: { message: 'を添付してください' }
  end

  with_options numericality: { greater_than: 0 } do
    validates :amount
    validates :calorie
  end

  validates :bar_code, format: { with: /\A[0-9]*\z/, message: 'は0から9の数字のみで入力してください' }

  def self.menu_list(menu)
    menu_ary = []
    menu_hash = {}

    value_1 = menu.amount / 3
    value_2 = menu.amount / 2
    value_3 = menu.amount
    value_4 = menu.amount * 2
    value_5 = menu.amount * 3

    calorie_1 = menu.calorie / 3
    calorie_2 = menu.calorie / 2
    calorie_3 = menu.calorie
    calorie_4 = menu.calorie * 2
    calorie_5 = menu.calorie * 3

    menu_hash[:value] = value_1
    menu_hash[:calorie] = calorie_1
    menu_ary << menu_hash
    menu_hash = {}

    menu_hash[:value] = value_2
    menu_hash[:calorie] = calorie_2
    menu_ary << menu_hash
    menu_hash = {}

    menu_hash[:value] = value_3
    menu_hash[:calorie] = calorie_3
    menu_ary << menu_hash
    menu_hash = {}

    menu_hash[:value] = value_4
    menu_hash[:calorie] = calorie_4
    menu_ary << menu_hash
    menu_hash = {}

    menu_hash[:value] = value_5
    menu_hash[:calorie] = calorie_5
    menu_ary << menu_hash
    menu_hash = {}

    menu_ary
  end
end
