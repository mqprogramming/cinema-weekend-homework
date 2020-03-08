require_relative('../db/sql_runner.rb')
# require_relative('customers')
# require_relative('films')

class Screening

  attr_reader :id
  attr_accessor :film_time, :film_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @film_time = options['film_time'].to_s
  end

  def save()
    sql = "INSERT INTO screenings
            (film_time, film_id)
            VALUES
            ($1, $2)
            RETURNING id"
    values = [@film_time, @film_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = "UPDATE screenings
    SET (film_time, film_id)
    = ($1, $2)
    WHERE id = $3"
    values = [@film_time, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end



end
