# create a db
require 'sequel'

task :create_db do
  #DB = Sequel.connect('sqlite://signs.db')
  DB = Sequel.connect('sqlite://signs.db')
  DB.create_table :submissions do
    primary_key :id
    Float :lat
    Float :long
    Int :accuracy
    String :image_id
    String :image_fname
  end
end
