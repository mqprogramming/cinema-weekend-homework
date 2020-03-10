require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/films.rb')
also_reload('.models/all')

get '/films' do
  @film_array = Film.all()
  erb(:index)
end

get '/films/:film_id' do
  @film_array = Film.all()
  @found_film = @film_array.find { |film| film.id == params[:film_id].to_i }
  erb(:film_page)
end
