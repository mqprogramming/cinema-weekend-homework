require_relative('../db/sql_runner.rb')
require_relative('customers')
require_relative('films')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_film_time

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_film_time = options['screening_film_time']
  end

  # SELECT tickets.* FROM tickets
  # INNER JOIN screenings
  # ON film_time = screening_film_time
  # WHERE tickets.film_id = 7;

  def save()
    sql = "INSERT INTO tickets
            (customer_id, film_id, screening_film_time)
            VALUES
            ($1, $2, $3)
            RETURNING id"
    values = [@customer_id, @film_id, @screening_film_time]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = "UPDATE tickets
    SET (customer_id, film_id, screening_film_time)
    = ($1, $2, $3)
    WHERE id = $4"
    values = [@customer_id, @film_id, @screening_film_time, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def film()
    sql = "SELECT * FROM films
           WHERE id = $1"
    values = [@film_id]
    desired_film = SqlRunner.run(sql, values).map { |film| Film.new(film) }
    return desired_film[0]
  end

  def film_price()
    return self.film.price.to_i
  end

end
