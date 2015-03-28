require 'sinatra'
require 'sinatra/partial'

# get '/' do
#   "Hello World!"
# end


register Sinatra::Partial
set :partial_template_engine, :erb

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


get '*' do
  redirect to('/')
end