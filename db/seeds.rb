# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

case Rails.env
when "development"
  unless User.exists?(email: 'dev@slowalk.co.kr')
    user = User.create! name: '최고 관리자', email: 'dev@slowalk.co.kr', password: 'qwer1234!', password_confirmation: 'qwer1234!'
    user.role = "super_admin"
    user.save
  end
end