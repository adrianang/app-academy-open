# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all

User.reset_pk_sequence
Artwork.reset_pk_sequence
ArtworkShare.reset_pk_sequence

user1 = User.create(username: "user1")
user2 = User.create(username: "user2")
user3 = User.create(username: "jennie")

artwork1 = Artwork.create(title: "title1", image_url: "img_url_1", artist_id: 1)
artwork2 = Artwork.create(title: "title2", image_url: "img_url_2", artist_id: 1)
artwork3 = Artwork.create(title: "title3", image_url: "img_url_3", artist_id: 2)
artwork4 = Artwork.create(title: "SOLO", image_url: "JENNIE - SOLO on YouTube", artist_id: 3)

artwork_share1 = ArtworkShare.create(artwork_id: 2, viewer_id: 2)
artwork_share2 = ArtworkShare.create(artwork_id: 1, viewer_id: 2)
artwork_share3 = ArtworkShare.create(artwork_id: 3, viewer_id: 1)
artwork_share4 = ArtworkShare.create(artwork_id: 4, viewer_id: 1)
artwork_share5 = ArtworkShare.create(artwork_id: 4, viewer_id: 2)