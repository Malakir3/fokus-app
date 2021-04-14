# users = []
# 5.times do |i|
#   users << User.new(firstname: "テスト", lastname: "太郎#{i+1}", nickname: "あだ名#{i+1}",
#                     birthday: "1990-04-01", email: "test#{i+1}@com", encrypted_password: "$2a$12$bwDsWTtIDrymeWShpPyC5uedngcFB.fK2rkHzvc5utDnwOfZ1AGmm" )
# end
# User.import users

menus = []
5.times do |i|
  menus << Menu.new(title: "食べ物#{i+1}", amount: (i + 100), unit: "g", calorie: (i + 300), bar_code: "000#{i+1}" )
end
Menu.import menus