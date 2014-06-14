require 'dotenv'
Dotenv.load

puts ENV

require 'haml'
require 'sequel'
require 'sinatra'
require 'uuid'

DB = Sequel.connect(ENV.fetch('DATABASE_URL'))

DB.create_table?(:submissions) do
  primary_key :id
  Float :lat
  Float :long
  Int :accuracy
  String :image_id
  String :image_fname
  DateTime :created_at
end

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
    image_id = uuid.generate
    image_fname =  image_id + '.jpg'
    if params.has_key?('photo-file')
      File.open('uploads/' + image_fname, "w") do |f|
        f.write(params['photo-file'][:tempfile].read)
      end
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
