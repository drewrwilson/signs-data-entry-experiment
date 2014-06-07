require 'rubygems'
require 'sinatra'

password = 'test'

# Handle GET-request (Show the upload form)
get "/upload" do
  File.read(File.join('views', 'upload.html'))
end

get "/" do
  File.read(File.join('views', 'index.html'))
end

# Handle POST-request (Receive and save the uploaded file)
post "/upload" do
  if params['password'] == password
    File.open('uploads/' + params['myfile'][:filename], "w") do |f|
      f.write(params['myfile'][:tempfile].read)
    end
    redirect '/?success=1'
  end
  # else return wrong password:
  return "Password wrong!"
end
