p "Seeding kg system of unit"
SystemOfUnit.find_or_create_by(symbol: 'kg') do |unit|
  unit.description = 'kilogram'
end

p "Seeding cm system of unit"
SystemOfUnit.find_or_create_by(symbol: 'cm') do |unit|
  unit.description = 'centimeter'
end

p "Seeding new user"
User.find_or_create_by(email: 'newuser@example.com') do |guest|
  guest.first_name = 'User'
  guest.last_name = 'Guest'
  guest.gender = 'female'
  guest.password = 'test1234'
  guest.height = Height.new(value: 185, system_of_unit: SystemOfUnit.find_by(symbol: 'cm'))
  guest.weight = Weight.new(value: 75, system_of_unit: SystemOfUnit.find_by(symbol: 'kg'))
end

p "Seeding admin user"
User.find_or_create_by(email: 'admin@example.com') do |admin|
  admin.first_name = 'Super'
  admin.last_name = 'Admin'
  admin.password = 'test1234'
  admin.gender = 'male'
  admin.add_role(:admin)
  admin.height = Height.new(value: 185, system_of_unit: SystemOfUnit.find_by(symbol: 'cm'))
  admin.weight = Weight.new(value: 75, system_of_unit: SystemOfUnit.find_by(symbol: 'kg'))
end

p "Seeding registered user"
User.find_or_create_by(email: 'foo@example.com') do |registered|
  registered.first_name = 'Foo'
  registered.last_name = 'Bar'
  registered.password = 'test1234'
  registered.gender = 'male'
  registered.add_role(:registered)
  registered.height = Height.new(value: 185, system_of_unit: SystemOfUnit.find_by(symbol: 'cm'))
  registered.weight = Weight.new(value: 75, system_of_unit: SystemOfUnit.find_by(symbol: 'kg'))
end

p "Seeding new user identity"
new_user = User.find_by_email('newuser@example.com')
if new_user.present?
  Identity.find_or_create_by(provider: 'email', user: new_user)
end

p "Seeding registered user identity"
registered_user = User.find_by_email('foo@example.com')
if registered_user.present?
  Identity.find_or_create_by(provider: 'email', user: registered_user)
end

p "Seeding admin user identity"
admin = User.find_by_email('admin@example.com')
if admin.present?
  Identity.find_or_create_by(provider: 'email', user: admin)
end