require 'gossip'
class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end
  
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/' do
    erb :show, locals: {gossip: Gossip.find(params['id'].to_i), id: params['id'].to_i}
  end

  get '/gossips/:id/edit/' do
    erb :edit, locals: {id: params['id'].to_i}
  end

  post '/gossips/:id/edit/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).update(params['id'].to_i)
    redirect "/gossips/#{params['id'].to_i}/"
  end
    
  
end

