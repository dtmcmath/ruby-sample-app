# By using the symbol ':user', we get Factory Girl to simulat the User model
Factory.define :user do |user|
  user.name                  'David McMath'
  user.email                 'dt.mcmath@gmail.com'
  user.password              'foobar'
  user.password_confirmation 'foobar'
end
