class UsersController < ApplicationController

  get "/:slug" do
    if logged_in? && current_user.slug === params[:slug]
      @user = current_user
      erb :"users/show"
    else
      redirect '/'
    end
  end

  post "/:slug" do
    if params[:name].empty?
      @user = current_user
      flash[:team_error] =  "can't be blank!"
      redirect "/#{current_user.slug}"
      flash[:messages].clear
    else
      @team = Team.new(name: params[:name])

      if @team.save
        current_user.teams << @team
        redirect "/#{current_user.slug}"
      end
    end
  end
end