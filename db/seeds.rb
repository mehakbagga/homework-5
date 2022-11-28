lorem_text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

Comment.destroy_all
Post.destroy_all
User.destroy_all

super_user = User.create(
    name: "Mehak",
    email: "mehakbagga55@gmail.com",
    password: "123",
    is_admin: true
)

10.times do
    name = Faker::Name.first_name
    User.create(
        name: name,
        email: "#{name.downcase}@gmail.com",
        password: "123"
    )
end

users = User.all


n = 1

55.times do
    p = Post.create(
            title: Faker::Book.title + "#{n}",
            body: lorem_text,
            user: users.sample
        )

    if p.valid?
        rand(5..10).times do
            Comment.create(
                body: Faker::Quote.matz,
                post: p,
                user: users.sample
            )
        end
    end

    n += 1
end