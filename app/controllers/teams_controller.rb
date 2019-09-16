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
    @team = Team.find(params[:team_id])

    if params[:first_name].empty? || params[:last_name].empty?
      flash[:first_name_error] = "can't be blank" if params[:first_name].empty?
      flash[:last_name_error] = "can't be blank" if params[:last_name].empty?
      redirect "/#{current_user.slug}/teams/#{@team.id}"
      flash[:messages].clear
    else
      @player = Player.new(first_name: params[:first_name], last_name: params[:last_name])

      if @player.save
        @team.players << @player
        current_user.players << @player
        redirect "/#{current_user.slug}/teams/#{@team.id}"
      end
    end
  end

  get "/:slug/teams/:team_id/edit" do
    @team = Team.find(params[:team_id])
    @user = @team.user
    erb :'teams/edit'
  end
  
  patch "/:slug/teams/:team_id" do
    @team = Team.find(params[:team_id])
    @team.name = params[:name]
    @team.save
    redirect to "/#{current_user.slug}"
  end

  # delete "teams/:id/delete" do
  #   @team = Team.find(params[:id])

  #   if @team.user_id === current_user.id
  #     @team.destroy
  #   end

  #   redirect "/#{current_user.slug}"
  # end
end