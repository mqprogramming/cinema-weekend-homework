require('pry')
require_relative('db/sql_runner.rb')
require_relative('models/customers.rb')
require_relative('models/films.rb')
require_relative('models/tickets.rb')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new(
  {
    'name' => 'Greg',
    'funds' => 100
  }
)
customer2 = Customer.new(
  {
    'name' => 'Tannis',
    'funds' => 150
  }
)
customer3 = Customer.new(
  {
    'name' => 'Charles',
    'funds' => 80
  }
)
customer4 = Customer.new(
  {
    'name' => 'Raghib',
    'funds' => 130
  }
)

customer1.save()
customer2.save()
customer3.save()
customer4.save()

film1 = Film.new(
  {
    'title' => 'Cautionary Tales from a DM',
    'price' => 50
  }
)
film2 = Film.new(
  {
    'title' => 'Dungeons for Dummies',
    'price' => 60
  }
)
film3 = Film.new(
  {
    'title' => 'Roll for Your Life',
    'price' => 40
  }
)

film1.save()
film2.save()
film3.save()

ticket1 = Ticket.new(
  {
    'customer_id' => customer1.id,
    'film_id' => film1.id
  }
)
ticket2 = Ticket.new(
  {
    'customer_id' => customer2.id,
    'film_id' => film2.id
  }
)
ticket3 = Ticket.new(
  {
    'customer_id' => customer1.id,
    'film_id' => film3.id
  }
)

ticket1.save()
ticket2.save()
ticket3.save()

# customer1.funds = 110
# customer1.update()

# customer1.delete()

binding.pry
nil
