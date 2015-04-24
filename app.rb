require 'sinatra'
require 'sinatra/partial'

require 'open-uri'

register Sinatra::Partial
set :partial_template_engine, :erb

before do
  expires 600, :public, :must_revalidate
end

get '/proxy' do
  output = URI.parse(params[:url]).read
end

#Index page
['/?', '/index', '/index.html'].each do |path|
  get path do
    erb :index
  end
end


['/mapreduce1', '/mapreduce1.html'].each do |path|
  get path do
    erb :mapreduce1
  end
end

['/mapreduce2', '/mapreduce2.html'].each do |path|
  get path do
    erb :mapreduce2
  end
end

['/mapreduce3', '/mapreduce3.html'].each do |path|
  get path do
    erb :mapreduce3
  end
end


['/kv1', '/kv1.html'].each do |path|
  get path do
    erb :kv1
  end
end

['/kv2', '/kv2.html'].each do |path|
  get path do
    erb :kv2
  end
end

['/dht1', '/dht1.html'].each do |path|
  get path do
    erb :dht1
  end
end

get '*' do |path|
  redirect to('/')
end