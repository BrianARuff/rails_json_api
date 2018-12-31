module Api
    module V1
        class ArticlesController < ApplicationController
            def index
                articles = Article.order('created_at DESC')
                render json: { status: 'SUCCESS', message: 'Loaded all articles', data:  articles }, status: :ok
            end
            
            def show
                article = Article.find(params[:id])
                render json: { status: "SUCESS", message: "Loaded #{params[:id]} article", data: article }, status: :ok
            end

            def create
                article = Article.new(article_params)
                if article.save
                    render json: { status: "SUCCESS", message: "Article #{params[:id]} posted", data: article }, status: :ok
                else
                    render json: { status: "ERROR", message: "Error: Article #{params[:id]} not posted", data: article.errors }, status: :unprocessable_entry
                end
            end

            def update
                article = Article.find(params[:id])
                if article.update(article_params)
                    render json: { status: "SUCCESS", message: "Article updated", data: article }, status: :ok
                else
                    render json: { status: "ERROR", message: "Error: Article #{params[:id]} not updated", data: article.errors }, status: :unprocessable_entry
                end
            end

            def destroy
                article = Article.find(params[:id])
                article.destroy
                render json: { status: "SUCCESS", message: "Article #{params[:id]} deleted", data: article }, status: :ok
            end

            private

            def article_params
                params.require(:article).permit(:title, :body)
            end
        end
    end
end