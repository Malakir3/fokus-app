require 'csv'

CSV.foreach('db/csv/user.csv', headers: true) do |row|
  User.create(
    firstname: row[0],
    lastname: row[1],
    nickname: row[2],
    birthday: row[3],
    email: row[4],
    password: row[5],
    password_confirmation: row[6]
  )
end

x = 1
CSV.foreach('db/csv/menu.csv', headers: true) do |row|
  menu = Menu.new(
    title: row[0],
    amount: row[1],
    unit: row[2],
    calorie: row[3],
    bar_code: row[4]
  )
  5.times do |i|
    menu.images.attach(io: File.open("public/images/#{x}/#{x}_#{i + 1}.jpg"), filename: "#{x}_#{i + 1}.jpg")
  end
  menu.save
  x += 1
end

CSV.foreach('db/csv/standard.csv', headers: true) do |row|
  Standard.create(
    user_id: row[0],
    menu_id: row[1],
    large: row[2],
    medium: row[3],
    small: row[4]
  )
end

CSV.foreach('db/csv/intake.csv', headers: true) do |row|
  Intake.create(
    user_id: row[0],
    menu_id: row[1],
    date: row[2],
    timing_id: row[3],
    value_id: row[4]
  )
end

# （保留中）画像だけDBに保存されない
# menus = []
# 2.times do |i|
#   menu = Menu.new(title: "食べ物#{i+1}", amount: (i + 100), unit: "g", calorie: (i + 300), bar_code: "000#{i+1}", images: [])
#   5.times do
#     menu.images.attach(io: File.open(Rails.root.join('public/images/test_image.jpg')), filename: 'test_image.jpg')
#   end
#   menus << menu
# end
# Menu.import menus