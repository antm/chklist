# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Task.create([
  {
    title: 'Task the first',
    duration: 180,
    important: false
  },
  {
    title: 'Task the second',
    duration: 180,
    important: true
  },
  {
    title: 'Task the third',
    duration: 180,
    important: true
  }

])