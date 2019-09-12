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
      team_error("Team name cannot be blank!")
    else
      @team = Team.new(name: params[:name])

      if @team.save
        current_user.teams << @team
        redirect "/#{current_user.slug}"
      end
    end
  end

  # Helpers

  def team_error(string)
    flash[:team_error] = string
    erb :'users/show'
  end
end