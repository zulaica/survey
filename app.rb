require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('pg')
require('sinatra/activerecord')
require('./lib/question')
require('./lib/survey')


get('/') do



  erb(:index)
end
