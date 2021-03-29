class Standard < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  has_many :intakes

  with_options numericality: { greater_than: 0 } do
    validates :large
    validates :medium
    validates :small
  end
end
