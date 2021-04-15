# users = []
# 5.times do |i|
#   users << User.new(firstname: "テスト", lastname: "太郎#{i+1}", nickname: "あだ名#{i+1}",
#                     birthday: "1990-04-01", email: "test#{i+1}@com", encrypted_password: "$2a$12$bwDsWTtIDrymeWShpPyC5uedngcFB.fK2rkHzvc5utDnwOfZ1AGmm" )
# end
# User.import users

# 画像は添付されているはずだが、画像だけDBに保存されない
# menus = []
# 3.times do |i|
#   menus << Menu.new(title: "食べ物#{i+1}", amount: (i + 100), unit: "g", calorie: (i + 300), bar_code: "000#{i+1}")
#   5.times do
#     menus[i].images.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
#   end
# end
# Menu.import menus

# CSV読み込みパターン
require 'csv'

x = 1
CSV.foreach('db/seed.csv', headers: true) do |row|
  menu = Menu.new(
    title: row[0],
    amount: row[1],
    unit: row[2],
    calorie: row[3],
    bar_code: row[4]
  )

  5.times do |i|
    menu.images.attach(io: File.open("public/images/#{x}/#{x}_#{i + 1}.jpg"), filename: "test_image_#{i + 1}.jpg")
  end
  menu.save
  
  x += 1
end


# importは使用しないが、画像を保存可能なコード
# 1.times do |i|
#   menu = Menu.new(title: "食べ物#{i+1}", amount: (i + 100), unit: "g", calorie: (i + 300), bar_code: "000#{i+1}")
#   5.times do
#     menu.images.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
#   end
#   menu.save
# end

# 画像だけDBに保存されない
# menus = []
# 2.times do |i|
#   menu = Menu.new(title: "食べ物#{i+1}", amount: (i + 100), unit: "g", calorie: (i + 300), bar_code: "000#{i+1}", images: [])
#   5.times do
#     menu.images.attach(io: File.open(Rails.root.join('public/images/test_image.jpg')), filename: 'test_image.jpg')
#   end
#   menus << menu
# end
# Menu.import menus