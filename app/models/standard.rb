class Standard < ApplicationRecord
  belongs_to :user
  belongs_to :menu

  with_options numericality: { greater_than: 0, message: 'を選択してください' } do
    validates :large
    validates :medium
    validates :small
  end

  def self.calorie_cal(targets)
    stn_ary = []
    if targets[0].nil?
      ary = []
      ary << targets
      targets = ary
    end
    targets.each do |standard|
      stn_hash = {}

      menu_cal = standard.menu.calorie
      menu_amount = standard.menu.amount
      stn_large = standard.large
      stn_medium = standard.medium
      stn_small = standard.small

      large_cal = menu_cal * stn_large / menu_amount
      medium_cal = menu_cal * stn_medium / menu_amount
      small_cal = menu_cal * stn_small / menu_amount

      stn_hash[:id] = standard.id
      stn_hash[:menu_id] = standard.menu_id
      stn_hash[:title] = standard.menu.title
      stn_hash[:large_amount] = stn_large
      stn_hash[:medium_amount] = stn_medium
      stn_hash[:small_amount] = stn_small
      stn_hash[:unit] = standard.menu.unit
      stn_hash[:large_cal] = large_cal
      stn_hash[:medium_cal] = medium_cal
      stn_hash[:small_cal] = small_cal
      stn_ary << stn_hash
    end
    stn_ary
  end

  def self.amount_cal(menu)
    amount_ary = []
    value1 = menu.amount / 3
    value2 = menu.amount / 2
    value3 = menu.amount
    value4 = menu.amount * 2
    value5 = menu.amount * 3

    amount_ary << value1
    amount_ary << value2
    amount_ary << value3
    amount_ary << value4
    amount_ary << value5
  end
end
