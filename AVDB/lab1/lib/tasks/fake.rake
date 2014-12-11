namespace :fake do
  desc "Generates Fake data to DB"

  task :db => :environment  do
    # fake_persons(100_000)
    fake_companies(1_000)
  end

  private

  def fake_persons(n)
    Person.destroy_all

    n.times do |i|
      p = Person.new

      p.name = Faker::Name.name
      p.address = "#{Faker::Address.city}, #{Faker::Address.street_address}"
      p.passport = Faker::Number.number(6)
      p.phone = Faker::PhoneNumber.cell_phone
      p.email = Faker::Internet.email
      p.skype = Faker::Internet.user_name
      p.almamater = Faker::Company.name
      p.sex = rand(10000)%2

      p.father = Person.order('random()').first
      p.mother = Person.order('random()').first

      if rand > 0.9
        spouse = Person.order('random()').first
        spouse.update_attribute(:spouse, p)
        p.spouse = spouse
      end

      p.save!
      printf("\rPersons_faker:  %.2f%", i/n.to_f * 100)
    end
  end
  def fake_companies(n)
    Company.destroy_all
    n.times do |i|
      c = Company.new

      c.name = Faker::Company.name
      c.address = "#{Faker::Address.city}, #{Faker::Address.street_address}"
      c.phone = Faker::PhoneNumber.cell_phone

      c.chief_id = Person.order('random()').first.id
      c.accountant_id = Person.order('random()').first.id

      if rand > 0.8
        c.head_company_id = Company.order('random()').first.id
      end

      c.save!
      printf("\rCompany_faker:  %.2f%", i/n.to_f * 100)
    end
  end
end
