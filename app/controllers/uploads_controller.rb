class UploadsController < ApplicationController
  def create
    upload = Upload.new(file: params[:file], movie_id: params[:movie_id])
    if upload.save
      render json: upload.file.to_json
    else
      render json: { err: 'File is not loaded.' }, status: 422
    end
  end

  def index
    return redirect_to movies_path unless params[:movie_id]
    @movie = Movie.find(params[:movie_id])
    @uploads = @movie.uploads.page params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end
end
