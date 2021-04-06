class Intake < ApplicationRecord
  belongs_to :user
  belongs_to :menu

  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :value
  belongs_to :timing

  validates :date, presence: true

  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :timing_id
    validates :value_id
  end
end
