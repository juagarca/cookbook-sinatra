require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "./lib/cookbook"
require_relative "./lib/recipe"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

def initialize
  @cookbook = Cookbook.new('./lib/recipes.csv')
end

get '/' do
  @recipes = @cookbook.all
  # binding.pry
  erb :index
end

get '/new' do
  erb :create
end

get '/recipes' do
  recipe = Recipe.new(name: params[:name], description: params[:description])
  @cookbook.add(recipe)
  redirect '/'
end

get '/team/:username' do
  binding.pry
  puts params[:username]
  "The username is #{params[:username]}"
end
