10.times do |n|
  User.create!(
    name: "user#{n}",
    email: "user.#{n}@example.com",
    phone: "123456789",
    visits: 0
  )
end
