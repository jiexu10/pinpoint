RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.start
    Role.create!(name: 'Customer')
    Role.create!(name: 'Restaurant')
    Role.create!(name: 'Driver')
  end
end

def find_role_id(string_name)
  Role.find_by(name: string_name)
end
