Property.delete_all
User.delete_all

3.times do
    user = User.create!(
                username: Faker::Internet.username[1..20] , 
                password:'password'
    )

    puts "Created a new user: #{user.username}"
   
    count = 1
    2.times do
        property = Property.create!(
            name: Faker::Commerce.product_name,
            address: Faker::Address.street_address,
            monthly_price: rand(1.0..100.0),
            is_for_rent: true,
            description: Faker::Lorem.sentence(word_count: 3),
            user_id: user.id
        )

        puts "Created a brand new property: #{property.name}"
        puts Property.first.featured_image
        property.featured_image.attach(io: 
            File.open(Rails.root.join("assets/images/#{count}.jpeg")), 
            filename: 'Dart.png', 
            content_type: 'image/png'
        )
        count += 1
    end
end