class CourtsController < ApplicationController
    before_action :require_login, only:[:update]
    def index
        @courts = Court.all
    end

    def show
        @court = Court.find(params[:id])
    end

    def update
        @court = Court.find(params[:id])
        @court.add_or_remove_favorite(current_player)
        redirect_to court_path(@court)
    end
end
