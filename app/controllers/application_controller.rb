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
    if !EmailAddress.valid?(params[:email])
      signup_error("Must use a valid email address!")
    elsif params[:password].size < 8
      signup_error("Password must be at least 8 characters long!")
    elsif User.find_by(email: params[:email])
      signup_error("Email is already in use!")
    else
      @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])

      if @user.save
        session[:user_id] = @user.id
        redirect "/#{current_user.slug}"
      else
        flash[:signup_error] = "Something else is wrong."
        erb :signup
      end
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
    @user = User.find_by(email: params[:email])
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


  # Users

  get "/:slug" do
    if logged_in?
      @user = current_user
      erb :coach
    else
      redirect '/'
    end
  end

  # Helpers

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def signup_error(string)
      flash[:signup_error] = string
      erb :signup
    end

    def login_error(string)
      flash[:login_error] = string
      erb :login
    end
  end
end
