# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Artwork.destroy_all

User.reset_pk_sequence
Artwork.reset_pk_sequence

user1 = User.create(username: "user1")
user2 = User.create(username: "user2")

artwork1 = Artwork.create(title: "title1", image_url: "img_url_1", artist_id: 1)
artwork2 = Artwork.create(title: "title2", image_url: "img_url_2", artist_id: 1)
artwork3 = Artwork.create(title: "title3", image_url: "img_url_3", artist_id: 2)