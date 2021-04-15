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

3.times do |i|
  menu = Menu.new(title: "食べ物#{i+1}", amount: (i + 100), unit: "g", calorie: (i + 300), bar_code: "000#{i+1}")
  5.times do
    menu.images.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
  end
  menu.save
end