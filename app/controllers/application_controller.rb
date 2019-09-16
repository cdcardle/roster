require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "the cow jumped over the moon"
  end

  # Home

  get "/" do
    if logged_in?
      redirect "/#{current_user.slug}"
    else
      redirect "/signup"
    end
  end

  # Signup

  get "/signup" do
    if logged_in?
      redirect "/#{current_user.slug}"
    else
      erb :signup
    end
  end

  post "/signup" do
    @user = User.new(email: params[:email],  username: params[:username], first_name: params[:first_name], last_name: params[:last_name], password: params[:password])

    if @user.save
      session[:user_id] = @user.id
      redirect "/#{current_user.slug}"
    else
      messages = @user.errors.messages

      if messages[:email]
        messages[:email].each{|message| flash[:email_error] = message if flash[:email_error] === nil}
      end
      if messages[:username]
        messages[:username].each{|message| flash[:username_error] = message if flash[:username_error] === nil}
      end
      if messages[:first_name]
        messages[:first_name].each{|message| flash[:first_name_error] = message if flash[:first_name_error] === nil}
      end
      if messages[:last_name]
        messages[:last_name].each{|message| flash[:last_name_error] = message if flash[:last_name_error] === nil}
      end
      if messages[:password]
        messages[:password].each{|message| flash[:password_error] = message if flash[:password_error] === nil}
      end

      redirect '/signup'
    end
  end

  # Login

  get "/login" do
    if logged_in?
      redirect "/#{current_user.slug}"
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/#{current_user.slug}"
    else
      login_error("Username or password is incorrect!")
    end
  end

  # Logout

  get '/logout' do
    session.clear if logged_in?
    redirect '/'
  end

  # Helpers

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def login_error(string)
      flash[:login_error] = string
      erb :login
    end
  end
end
