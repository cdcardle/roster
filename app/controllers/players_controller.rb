class PlayersController < ApplicationController
  get '/:slug/teams/:team_id/players/:player_id' do
    if logged_in? && current_user.slug == params[:slug]
      @player = Player.find(params[:player_id])
      erb :"players/show"
    else
      redirect '/'
    end
  end
end