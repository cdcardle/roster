class TeamsController < ApplicationController
  get '/:slug/teams/:team_id' do
    if logged_in? && current_user.slug === params[:slug]
      @team = Team.find(params[:team_id])
      erb :"teams/show"
    else
      redirect '/'
    end
  end
end