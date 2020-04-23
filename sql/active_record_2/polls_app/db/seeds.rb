# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

User.reset_pk_sequence
Poll.reset_pk_sequence
Question.reset_pk_sequence
AnswerChoice.reset_pk_sequence
Response.reset_pk_sequence

user1 = User.create(username: "Joji")
user2 = User.create(username: "RichBrian")

poll1 = Poll.create(title: "88rising Songs", user_id: user1.id)
poll2 = Poll.create(title: "Cooks in 88rising", user_id: user2.id)

question1 = Question.create(text: "Favorite 88rising Songs", poll_id: poll1.id)
question2 = Question.create(text: "Least favorite 88rising Songs", poll_id: poll1.id)
question3 = Question.create(text: "Best cook in 88rising", poll_id: poll2.id)
question4 = Question.create(text: "Okay cooks in 88rising", poll_id: poll2.id)

answer_choice1 = AnswerChoice.create(text: "Midsummer Madness", question_id: question1.id)
answer_choice2 = AnswerChoice.create(text: "I Love You 3000 II", question_id: question1.id)
answer_choice3 = AnswerChoice.create(text: "Indigo", question_id: question1.id)
answer_choice4 = AnswerChoice.create(text: "Midsummer Madness", question_id: question2.id)
answer_choice5 = AnswerChoice.create(text: "I Love You 3000 II", question_id: question2.id)
answer_choice6 = AnswerChoice.create(text: "Indigo", question_id: question2.id)
answer_choice7 = AnswerChoice.create(text: "Joji", question_id: question3.id)
answer_choice8 = AnswerChoice.create(text: "Rich Brian", question_id: question3.id)
answer_choice9 = AnswerChoice.create(text: "Niki", question_id: question3.id)
answer_choice10 = AnswerChoice.create(text: "Joji", question_id: question4.id)
answer_choice11 = AnswerChoice.create(text: "Rich Brian", question_id: question4.id)
answer_choice12 = AnswerChoice.create(text: "Niki", question_id: question4.id)

response1 = Response.create(answer_choice_id: answer_choice1.id, user_id: user1.id)
response2 = Response.create(answer_choice_id: answer_choice6.id, user_id: user1.id)
response3 = Response.create(answer_choice_id: answer_choice7.id, user_id: user1.id)
response4 = Response.create(answer_choice_id: answer_choice11.id, user_id: user1.id)
response5 = Response.create(answer_choice_id: answer_choice1.id, user_id: user2.id)
response6 = Response.create(answer_choice_id: answer_choice5.id, user_id: user2.id)
response7 = Response.create(answer_choice_id: answer_choice8.id, user_id: user2.id)
response8 = Response.create(answer_choice_id: answer_choice12.id, user_id: user2.id)
