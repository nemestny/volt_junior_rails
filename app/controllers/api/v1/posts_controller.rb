module Api
  module V1
    class PostsController < ApplicationController
      def index
        render json: {
          error: 'hello'
        }
      end
    end
  end
end
