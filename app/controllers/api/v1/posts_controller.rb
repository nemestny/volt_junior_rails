module Api
  module V1
    class PostsController < ApplicationController
#curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDk0MzIxNzN9.nAiorIPk1gqOP71SHyABn9HbjFvAzqB002sibJOpfks" http://localhost:3000/api/v1/posts.json     
      def index
        posts = Post.all
        render json: posts
      end
#curl -H "Content-Type: application/json" -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDk0MzIxNzN9.nAiorIPk1gqOP71SHyABn9HbjFvAzqB002sibJOpfks" -d '{"title":"title1", "body":"body2"}' -X POST  http://localhost:3000/api/v1/posts.json

      def create
        p params
        p permit_params
        post = Post.new permit_params
        post.user = current_user
        if post.valid?
          post.save
          render json: post
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
