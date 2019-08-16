class SquadsController < ApplicationController
    def index
        @squads = Squad.all
        @new_squad = Squad.new
    end

    def create
        squad = current_player.create_squad_from_hash(squad_params)
        if squad.save
            redirect_to squad_path(squad)
        else
            render :index
        end
    end

    private
    def squad_params
        params.require(:squad).permit(:name)
    end
end
