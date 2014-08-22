require 'sinatra'
require 'pry'
require 'sinatra/reloader'
require 'csv'

def get_submission
	articles = []

	CSV.foreach('articles.csv', headers: true) do |article|
		articles << article
	end
	articles
end
 
get '/articles' do
	@articles = get_submission
	erb :index_articles
end

get '/' do
	erb :index
end
 
get '/submit' do
	erb :index_submit
end

post '/submit' do
	title = params["title"]
	url = params["url"]
	description = params["description"]

		CSV.open('articles.csv', 'a') do |article|
			article << [title, url, description]
		end
	redirect '/articles'
end
