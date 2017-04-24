# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Department.create!(name: 'Support')
Department.create!(name: 'Development')
Department.create!(name: 'Other')
Department.create!(name: '...')
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password',
             department_id: Department.first.id, name: 'Admin' )
['New unassigned tickets', 'Open Tickets', 'On hold tickets', 'Closed Tickets'].each do |n|
  StatusGroup.create!(name: n)
end
[{title: 'Waiting for Staff Response', status_group_id: 2}, {title: 'Waiting for Customer', status_group_id: 2},
 {title: 'On Hold', status_group_id: 3}, {title: 'Cancelled', status_group_id: 4},
 {title: 'Completed', status_group_id: 4} ].each_with_index do |v, i|
  Status.create!(v.merge({ sorter: i }))
end