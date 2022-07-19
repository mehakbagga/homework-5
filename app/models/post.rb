class Post < ApplicationRecord

    validates :title, presence: {message: "must be provided"},
    uniqueness: {scope: :body}, length: {minimum: 2, maximum: 200}

    validates :body, presence: true, length: {minimum: 50}
end
