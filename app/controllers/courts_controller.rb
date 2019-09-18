class CourtsController < ApplicationController
    before_action :require_login, only:[:update, :show]
    def index
        @courts = Court.all
        respond_to do |format|
            format.html { render :index }
            format.json { render json: @courts, each_serializer: SimpleCourtSerializer }
        end
    end

    def show
        @court = Court.find(params[:id])
        respond_to do |format|
            format.html { render :show }
            format.json { render json: @court, serializer: CompleteCourtSerializer, include: [:upcoming_games] }
        end
    end

    def update
        @court = Court.find(params[:id])
        @court.add_or_remove_favorite(current_player)
        respond_to do |format|
            format.html {redirect_to court_path(@court)}
            format.json {render json: @court, serializer: CompleteCourtSerializer, include: [:upcoming_games]}
        end
    end
end
