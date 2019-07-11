class GenresController < ApplicationController

  def new
  	@genre = Genre.new
  	@genres = Genre.page(params[:page])
  end

  def create
  	@genre = Genre.new(genre_params)

	if @genre.save
		flash[:notice] = 'ジャンルを新規登録しました.'
		redirect_to new_novel_path
	else
		redirect_to new_genre_path
	end
  end
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to new_genre_path
  end

  private
  def genre_params
  	params.require(:genre).permit(:genre_name)

  end
end
