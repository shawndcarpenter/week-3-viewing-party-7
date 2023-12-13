class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index 
    # @user = User.find(params[:id])
    @movies = Movie.all
  end 

  def show 
    # @user = User.find(params[:user_id])
    @movie = Movie.find(params[:id])
  end 

  private
  def not_found_response
    redirect_to "/movies"
    flash[:error] = "You must be logged in or registered to create a movie party."
  end
end 