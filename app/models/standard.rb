class Standard < ApplicationRecord
  belongs_to :user
  belongs_to :menu

  with_options numericality: { greater_than: 0 } do
    validates :large
    validates :medium
    validates :small
  end
end
