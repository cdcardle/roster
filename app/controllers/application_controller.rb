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
    erb :signup
  end

  post "/signup" do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect "/#{current_user.slug}"
      else
        redirect "/error"
      end
    end
  end

  # Login

  get "/login" do
    if logged_in?
      redirect `#{current_user.slug}`
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/#{current_user.slug}/tweets"
    else
      redirect '/login_error'
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
      erb :roster
    else
      redirect '/'
    end
  end

  # Errors

  get "/login_error" do
    erb :login_error
  end

  get "/error" do
    erb :error
  end

  # Helpers

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
