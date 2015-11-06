namespace :db do
  # Populate file and structure taken from PATS
  # First, this populate destroys everything in the database
  # Second, this creates some filters, orgs, and users who are approvers
  # Third, this creates normal users, their keys, their key's rights,
  # their's keys comments, and their keys approvals if applicable

  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'

    # Step 1: clear any old data in the db
    [User].each(&:delete_all)

    # Step 2: Add in fake data
    # Fake Users
    num_users = 10
    for i in 0..num_users
      user = User.new
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name
      user.email = Faker::Internet.email(user.first_name)
      user.password_digest = Faker::Internet.password(10)
      user.save!
    end

    # Fake Cards
    for i in 0..12
      card = Card.new
      # some people with multiple cards, some without any
      card.user_id = rand(1..num_users-1)
      card.card_number = Faker::Business.credit_card_number
      card.holder_name = Faker::Name.name
      card.zip_code = Faker::Address.postcode.slice(0, 5)
      card.expiration_date = Faker::Business.credit_card_expiry_date
      card.csv_code = Faker::Number.number(3)
      card.save!
    end

    # Fake Purchases
    for i in 0..20

    end
  end
end
