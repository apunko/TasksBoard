# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Task.create(title: "first_task", description: "I live here", level: 1, user_id: 2)

AnswerAttempt.create(value: "anything", result: false, task_id: 8, user_id: 5)
AnswerAttempt.create(value: "something", result: false, task_id: 8, user_id: 5) 