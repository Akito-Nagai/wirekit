# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_role = Role.find_or_initialize_by(code: 'admin')
if admin_role.new_record?
  admin_role.update!(sort: 1, name: '特権管理者',
    policy: '{ permit_url_regexp: ".*" }',
    description: 'システム管理機能を使用することができます。')
end

if admin_role.users.empty?
  admin_user = User.find_or_initialize_by(email: 'admin@example.com')
  if admin_user.new_record?
    admin_user.update!(
        nick_name: '管理者',
        email: 'admin@example.com',
        #password: 'adminadmin',
        confirmed_at: Time.now,
        role_ids: [admin_role.id]
      )
  end
end

Lounge.find_or_create_by(name: 'default') do |r|
  r.name = 'default'
end
