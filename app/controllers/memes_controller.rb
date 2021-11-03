class MemesController < ApplicationController
    def index
        memes = Meme.all
        render json: memes
      end

      def create
        meme = Meme.create(meme_params)
        if meme.valid?
          render json: meme
        else
          render json: meme.errors, status: 422
        end
      end

      def update
        meme = Meme.find(params[:id])
        meme.update(meme_params)
        if meme.valid?
          render json: meme
        else
          render json: meme.errors, status: 422
        end
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
