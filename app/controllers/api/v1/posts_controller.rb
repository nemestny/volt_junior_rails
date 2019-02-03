module Api
  module V1
    class PostsController < ApplicationController
      
      def index
        render json: {
          error: 'index'
        }
      end

      def create
        render json: {
          error: 'create'
        }
      end

      def show
        render json: {
          error: params #test comment
        }
      end
    end
  end
end
