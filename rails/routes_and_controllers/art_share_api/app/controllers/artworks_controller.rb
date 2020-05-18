class ArtworksController < ApplicationController
  def index
    artist = User.find(params[:user_id])

    artworks_owned_by_user = artist.artworks
    artworks_shared_with_user = artist.shared_artworks
    all_artworks = artworks_owned_by_user + artworks_shared_with_user
    render json: all_artworks
  end

  def create
    artwork = Artwork.new(artwork_params)

    if artwork.save
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    artwork = Artwork.find_by(id: params[:id])
    render json: artwork
  end

  def update
    artwork = Artwork.find_by(id: params[:id])
    
    if artwork.update(artwork_params)
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artwork = Artwork.find_by(id: params[:id])

    if artwork.destroy
      render json: artwork
    else
      render json: "Cannot delete this artwork"
    end
  end

  private
  def artwork_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end
end