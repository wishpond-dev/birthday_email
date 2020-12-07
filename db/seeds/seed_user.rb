class SeedUser
  require 'faker'

  def execute
    1000.times do
      create_user
    end
  end

  private

  def create_user
    user = User.create(
      encrypted_username: Faker::Name.name,
      encrypted_email: Faker::Internet.email,
      birthdate: Faker::Date.between(from: '01/01/1982', to: '31/12/1982')
    )
  end
end
