require 'tempfile'

class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def show
    @rating = Rating.find(params[:id])
  end

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(rating_params)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @rating, notice: 'Rating was successfully created.' }
        format.json { render :show, status: :created, json: @rating }
      else
        format.html { render :new }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def image
    @rating = Rating.find(params[:id])

    tempfile = Tempfile.new(['image', 'jpg'])
    tempfile.binmode
    tempfile.write(request.body.read)

    @rating.image = ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, filename: 'image.jpg')

    respond_to do |format|
      if @rating.save
        format.json { render :show, status: :accepted, json: @rating }
      else
        format.json { render json: {}, status: :unprocessable_entity }
      end
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:description, :image)
  end
end
