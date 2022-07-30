# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Post.destroy_all
Answer.destroy_all
User.destroy_all

PASSWORD='123'
super_user= User.create(
    first_name: 'Mehak',
    last_name:'Bagga',
    email: 'mb@winterfell.gov',
    password: PASSWORD
)
10.times do
first_name= Faker::Name.first_name 
last_name= Faker::Name.last_name 
User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}.#{last_name}@example.com",
    password: PASSWORD
)
end
users=User.all

200.times do
     created_at=Faker::Date.backward(days: 365*5)
    p=Post.create(
        title: Faker::Hacker.say_something_smart,
        body: Faker::ChuckNorris.fact,

        created_at: created_at,
        updated_at: created_at,
        user: users.sample
    )
    if p.valid?
        p.answers = rand(0..15).times.map do 
            Comment.new(
                body: Faker::GreekPhilosophers.quote, 
                user: users.sample )
        end
    end
end

post=Post.all
answer=Answer.all

puts Cowsay.say("Generated #{post.count} posts.",:frogs)
puts Cowsay.say("Generated #{answer.count} commnents.",:tux)
puts Cowsay.say("Generated #{users.count} users.",:beavis)
puts Cowsay.say("Login with  #{super_user.email} and password:#{PASSWORD}.",:koala)