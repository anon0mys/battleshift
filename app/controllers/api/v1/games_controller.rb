module Api
  module V1
    class GamesController < ApiController
      def show
        game = Game.find(params[:id])
        render json: game
      end
    end
  end
end
