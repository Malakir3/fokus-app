class Value < ActiveHash::Base
  self.data = [
    { id:1, name: '--' },
    { id:2, name: '少なめ' },
    { id:3, name: '普通' },
    { id:4, name: '多め' }
  ]

  include ActiveHash::Associations
  has_many :intakes
end