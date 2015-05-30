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

['/kv3', '/kv3.html'].each do |path|
  get path do
    erb :kv3
  end
end

['/dht1', '/dht1.html'].each do |path|
  get path do
    erb :dht1
  end
end

['/dht2', '/dht2.html'].each do |path|
  get path do
    erb :dht2
  end
end

['/google0363eef37e506ec9.html'].each do |path|
  get path do
    File.read(File.join('public', 'google0363eef37e506ec9.html'))
  end
end

get '*' do |path|
  redirect to('/')
end