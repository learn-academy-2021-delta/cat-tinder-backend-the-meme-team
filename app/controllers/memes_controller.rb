class MemesController < ApplicationController
    def index
        memes = Meme.all
        render json: memes
      end

      def create
        meme = Meme.create(meme_params)
        render json: meme
      end

      def update
        meme = Meme.find(params[:id])
        meme.update(meme_params)
        render json: meme
      end

      def destroy
        meme = Meme.find(params[:id])
        meme.destroy
        render json: meme
      end

      private 
      def meme_params
        params.require(:meme).permit(:name, :url, :description)
      end

    
end
