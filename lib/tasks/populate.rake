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
    [User, Card, Purchase, Store, Item, PurchasedItem].each(&:delete_all)

    # Step 2: Add in fake data
    # Fake Users
    num_users = 10
    for i in 1..num_users
      user = User.new
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name
      user.email = Faker::Internet.email(user.first_name)
      user.password_digest = Faker::Internet.password(10)
      user.save!
    end

    # Fake Cards
    num_cards = 12
    for i in 1..num_cards
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
    num_purchases = 20
    for i in 1..num_purchases
      p = Purchase.new
      p.user_id = rand(1..num_users-1)
      rand_user = User.find_by_id(p.user_id)
      cards = rand_user.cards.map{ |c| c.id }
      while cards.length == 0
        p.user_id = rand(1..num_users-1)
        rand_user = User.find_by_id(p.user_id)
        cards = rand_user.cards.map{ |c| c.id }
      end
      p.card_id = cards[rand(0..cards.length-1)]
      p.save!
    end

    # Fake Stores
    num_stores = 4
    for i in 1..num_stores
      store = Store.new
      store.name = Faker::Company.name
      store.zip = Faker::Address.postcode[0..4] # only want five digit zips
      store.save!
    end

    # Fake Items
    num_items = 15
    for i in 1..num_items
      item = Item.new
      item.store_id = rand(1..4) # want to keep one store with no items
      item.name = Faker::Commerce.product_name
      item.price = rand(1..20)
      item.save!
    end

    # Fake PurchasedItems
    num_purchased_items = 30
    for i in 1..num_purchased_items
      p_item = PurchasedItem.new
      p_item.item_id = rand(1..12) # leave some items that haven't been purchased
      p_item.purchase_id = rand(1..num_purchases)
      # the buyer_id should match the user_id from the purchase
      purchase = Purchase.find_by_id(p_item.purchase_id)
      p_item.buyer_id = purchase.user_id
      # a user shouldn't be able to buy himself a coffee
      p_item.redeemer_id = rand(1..num_users)
      while p_item.buyer_id == p_item.redeemer_id
        p_item.redeemer_id = rand(1..num_users)
      end
      p_item.is_redeemed = rand(0..1) == 1 ? true : false
      p_item.save!
    end
  end
end
