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

    menu_hash[:value] = menu.amount / 3
    menu_hash[:calorie] = menu.calorie / 3
    menu_ary << menu_hash
    menu_hash = {}

    menu_hash[:value] = menu.amount / 2
    menu_hash[:calorie] = menu.calorie / 2
    menu_ary << menu_hash
    menu_hash = {}

    menu_hash[:value] = menu.amount
    menu_hash[:calorie] = menu.calorie
    menu_ary << menu_hash
    menu_hash = {}

    menu_hash[:value] = menu.amount * 2
    menu_hash[:calorie] = menu.calorie * 2
    menu_ary << menu_hash
    menu_hash = {}

    menu_hash[:value] = menu.amount * 3
    menu_hash[:calorie] = menu.calorie * 3
    menu_ary << menu_hash

    menu_ary
  end
end
