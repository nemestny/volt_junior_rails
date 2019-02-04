module Api
  module V1
    class PostsController < ApplicationController
      
      def index
        render json: {
          error: 'index'
        }
      end

      def create
        # p params
        # p permit_params
        post = Post.new permit_params
        post.user = current_user
        if post.valid?
          post.save
          render json: post.to_json
        else
          render json: {errors: post.errors.messages}
        end
      end

      def show
        render json: {
          error: params #test comment
        }
      end

      private

      def permit_params
        params.permit(:title, :body, :published_at)
      end
    end
  end
end
