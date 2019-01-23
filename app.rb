require 'sinatra'
require 'sinatra/flash'
require_relative 'models'
require_relative './class'


set :sessions, true
use Rack::MethodOverride

def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    end
  end

get "/" do
    
    erb :index
end

get "/locations" do

    erb :locations
end

get "/excursions" do

    @activities =[
        @skydiving = Adventures.new("Skydiving", "https://i1.wp.com/www.thejumpingplace.com/wp-content/uploads/2013/08/529232_10101720562241321_209875322_n.jpg?fit=841%2C561", "$200/jump", "Very Extreme"),
        @bungiejumping = Adventures.new("Bungie Jumping", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiTihlV92KLk5X2yOO8dnC_y1dZjLfG177hMyWFLf98yU-PoPO", "$79.99/jump", "Extreme"),
        @atv = Adventures.new("ATV Explorer", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvOLTux7dMuATevnf13-hhZwMYEVhTb6L2Ms3ymDv0v0MFgfAG", "$29.99/ATV", "Moderately extreme"),
        @scuba = Adventures.new("ScubaDiving", "http://mauidiving.com/wp-content/uploads/2017/05/manta2.jpg", "$200/day", "Relaxing"),
        @snowboarding = Adventures.new("Snowboarding", "https://thumbor.thedailymeal.com/4r0BZpNGNji19ZSM6a6INUhTiPM=/774x516/https://www.theactivetimes.com/sites/default/files/images/1_bestsnowboarding_mammoth_facebook_ss.png", "$50/lift ticket", "Moderate"),
        @fishing = Adventures.new("Big Game Fishishg", "https://i.ytimg.com/vi/xfLbmirbbm4/maxresdefault.jpg", "$400/boat", "Risky")
    ]

    erb :excursions
end

get "/about" do

    erb :about
end

get '/users' do
    
    @users = User.all

    
  
    
    erb :users 
  end

get "/signup" do
    erb :signup
end

post "/signup" do
    user = User.create(
        first_name: params[:firstname],
        last_name: params[:lastname],
        username: params[:username],
        password: params[:password],
        email: params[:email],
        birthday: params[:birthday]
    )

    

    session[:user_id] = user.id

    redirect "/users"

end

get "/signin" do 
    erb :signin
end

post "/signin" do 
    user = User.find_by(username: params[:username])

    if user && user.password == params[:password]

        session[:user_id]=user.id

        flash[:info] = 'You have been signed in'


    else
        
        flash[:error] = 'There was a problem with your signin'
        redirect "/signin"

        
    end
    
    erb :admin
    

end

get "/admin" do
    erb :admin
end

get "/blog" do

    @posts = Post.order('created_at DESC').limit(20)
    

    erb :blog

end

post "/admin" do
 post = Post.create(
     title: params[:title],
     content: params[:content],
     image_url: params[:image_url],
     user_id: current_user.id
     
 )
 

 redirect "/blog" 

 end

 get "/profiles" do

    @user = User.find_by(username: params[:username])
    

    if @user
        @userposts = @user.posts.order('created_at DESC').limit(20)


        erb :profiles
    else
        
        flash[:error2] = 'User does not exist'
        redirect "/admin"
    end

    
end

get "/myprofile" do

    @myuser = User.find_by(id: session[:user_id])

    erb :myprofile

end



get "/signout" do
    session[:user_id] = nil

    redirect "/"
end

get '/account' do
    erb :account
  end
  
  delete '/user/:id' do 

    @user = User.find(session[:user_id])
    User.destroy(session[:user_id])
    
    session[:user_id] = nil
   
    
    redirect "/"
  
    flash[:delete] = 'your account has been deleted'
  end


