require 'rubygems'
require 'sinatra'
require 'haml'

# configure :development do
#     DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
# end
#
# configure :production do
#     DataMapper.setup(:default, ENV['HEROKU_POSTGRESQL_RED_URL'])
# end

password = 'test'

# Handle GET-request (Show the upload form)
get "/upload" do
  haml :upload
end

get "/" do
  haml :index
end

# Handle POST-request (Receive and save the uploaded file)
post "/upload" do
  if params['password'] == password
    File.open('uploads/' + params['myfile'][:filename], "w") do |f|
      f.write(params['myfile'][:tempfile].read)
    end
    redirect '/?success=1'
  end
  # else return 'wrong password':
  return "Password wrong!"
end
