class Post < ApplicationRecord

    validates :title, presence: {message: "must be provided"},
    uniqueness: true, length: {minimum: 2, maximum: 200}

    validates :body, presence: true, length: {minimum: 50}

    has_many :answers, dependent: :destroy
end