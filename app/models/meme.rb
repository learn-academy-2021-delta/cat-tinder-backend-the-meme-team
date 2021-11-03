class Meme < ApplicationRecord
    validates :name, :url, :description, presence: true
    validates :description, length: {minimum: 10}
end
