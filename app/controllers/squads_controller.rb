class SquadsController < ApplicationController
    def index
        @squads = Squad.all
        @new_squad = Squad.new
    end

    def create
        squad = current_player.create_team()
        if squad.save
            redirect_to squads_path
        else
            render :index
        end
    end

    private
    def squad_params
        params.require(:squad).permit(:name)
    end
end
