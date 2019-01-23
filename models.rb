require 'sinatra/activerecord'
require 'pg'



configure :development do
    set :database, 'postgresql:travellr'
  end
  
  # on heroku
  configure :production do
    set :database, ENV['DATABASE_URL']
  end

class User < ActiveRecord::Base
    has_many :posts, :dependent => :destroy
    
end

class Post < ActiveRecord::Base
    belongs_to :user

end

