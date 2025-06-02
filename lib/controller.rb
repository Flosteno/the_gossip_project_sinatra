require 'gossip'
require 'comment'
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
    id = params["id"].to_i
    erb :show, locals: {gossip: Gossip.find(id), id: id, comments: Comment.all(id)}
  end

  get '/gossips/:id/edit/' do
    erb :edit, locals: {id: params['id'].to_i}
  end

  post '/gossips/:id/edit/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).update(params['id'].to_i)
    redirect "/gossips/#{params['id'].to_i}/"
  end

  post '/gossips/:id/newC/' do
    Comment.new(params["id"].to_i, params["comment_author"], params["comment_content"]).create_comment
    redirect "/gossips/#{params["id"].to_i}/" 
  end

  post '/gossips/:id/deleteA/' do
    Comment.delete_all(params["id"])
    redirect "/gossips/#{params["id"].to_i}/"
  end


    
  
end

