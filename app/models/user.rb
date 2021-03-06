class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :standards
  has_many :intakes

  with_options presence: true do
    validates :firstname
    validates :lastname
    validates :nickname
    validates :birthday
  end
end
