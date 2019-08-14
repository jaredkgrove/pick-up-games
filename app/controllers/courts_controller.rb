class CourtsController < ApplicationController
    def index
        @courts = Court.all
    end

    def show
        @court = Court.find(:id)
    end
end
