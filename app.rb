require 'rubygems'
require 'sequel'
require 'sinatra'
require 'uuid'
require 'haml'

# connect to an in-memory database
DB = Sequel.connect('sqlite://signs.db')
submissions = DB[:submissions]

uuid = UUID.new


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
  if params['password'].downcase == password.downcase
    image_id = uuid.generat
    image_fname =  image_id + '.jpg'
    File.open('uploads/' + image_fname, "w") do |f|
      f.write(params['photo-file'][:tempfile].read)
    end
    submissions.insert(
      :lat => params['lat'],
      :long => params['long'],
      :accuracy => params['accuracy'],
      :image_id => image_id,
      :image_fname => image_fname
      )
    redirect '/?success=1'
  end
  # else return 'wrong password':
  return "Password wrong!"
end
