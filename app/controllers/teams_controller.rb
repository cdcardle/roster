class TeamsController < ApplicationController

  get '/:slug/teams/:team_id' do
    if logged_in? && current_user.slug === params[:slug]
      @team = Team.find(params[:team_id])
      erb :"teams/show"
    else
      redirect '/'
    end
  end

  post "/:slug/teams/:team_id" do
    if params[:first_name].empty? || params[:last_name].empty?
      @team = Team.find(params[:team_id])
      player_error("Names cannot be blank!")
      redirect "/#{current_user.slug}/teams/#{@team.id}"
      flash[:messages].clear
    else
      @player = Player.new(first_name: params[:first_name], last_name: params[:last_name])

      if @player.save
        team = Team.find(params[:team_id])
        team.players << @player
        current_user.players << @player
        redirect "/#{current_user.slug}/teams/#{team.id}"
      end
    end
  end

  # Helpers

  def player_error(string)
    flash[:player_error] = string
    erb :"teams/show"
  end
end