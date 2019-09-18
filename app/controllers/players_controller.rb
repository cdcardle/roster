class PlayersController < ApplicationController
  get '/:slug/teams/:team_id/players/:player_id' do
    if logged_in? && current_user.slug == params[:slug]
      @player = Player.find(params[:player_id])
      erb :"players/show"
    else
      redirect '/'
    end
  end

  get "/:slug/teams/:team_id/players/:player_id/edit" do
    @player = Player.find(params[:player_id])
    @user = @player.user
    @team = @player.team
    erb :'players/edit'
  end
  
  patch "/:slug/teams/:team_id/players/:player_id" do
    @player = Player.find(params[:player_id])
    @player.first_name = params[:first_name]
    @player.last_name = params[:last_name]
    @player.save
    redirect to "/#{current_user.slug}/teams/#{params[:team_id]}"
  end
end