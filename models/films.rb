require_relative('../db/sql_runner.rb')
require_relative('customers')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
            (title, price)
            VALUES
            ($1, $2)
            RETURNING id"
    values = [@title, @price]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = "UPDATE films
    SET (title, price)
    = ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT customers.* FROM customers
          INNER JOIN tickets
          ON customer_id = customers.id
          WHERE film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map { |customer| Customer.new(customer) }
  end

  def customer_count()
    return self.customers.count()
  end

end
