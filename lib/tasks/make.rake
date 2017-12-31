namespace :make do
  task fake_restaurant: :environment do
  Restaurant.destroy_all

  500.times do |i|
    Restaurant.create!(name: FFaker::Name.first_name,opening_hours: FFaker::Time.datetime,
      tel: FFaker::PhoneNumber.short_phone_number,
      address: FFaker::Address.street_address,
      description: FFaker::Lorem.paragraph  ,
      category: Category.all.sample
      )  
  end
  puts "have created fake restaurants"
  puts "now you have #{Restaurant.count} restaurants data"
end

  
  task fake_user: :environment do
      20.times do |i|
      #user_name = FFaker::Name.first_name
      User.create!(
        email: "#{FFaker::Name.first_name}@example.com",
        password: "1qaz2wsx"
      )  
      end
      puts "have created fake user"
      puts "now you have #{User.count} user data"
  end


  task fake_comment: :environment do
    Restaurant.all.each do |restaurant|
      3.times do |i|
      restaurant.comments.create!(
        content: FFaker::Lorem.sentence,
        user: User.all.sample
      )  
      end
    end
      puts "have created fake comment"
      puts "now you have #{Comment.count} ccomment data"
  end
end