require 'rubygems'
require 'sinatra'
require 'haml'

# Handle GET-request (Show the upload form)
get "/upload" do
  File.read(File.join('views', 'upload.html'))
end

# Handle POST-request (Receive and save the uploaded file)
post "/upload" do
  if params['password'] == 'pw1'
    File.open('uploads/' + params['myfile'][:filename], "w") do |f|
      f.write(params['myfile'][:tempfile].read)
    end
    return "The file was successfully uploaded!"
  end
  # else return wrong password:
  return "Password wrong!"
end
