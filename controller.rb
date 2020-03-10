require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/films.rb')
also_reload('.models/all')

get '/films' do
  film_array = Film.all()
  @film_titles = film_array.map { |film| film.title }
  erb(:index)
end
