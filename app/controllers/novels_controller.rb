class NovelsController < ApplicationController
	def index


		if params[:tag_name]
			@novels = Novel.tagged_with(params[:tag_name])
		elsif params[:genre_id]
			@novels =  Novel.where(genre_id: params[:genre_id])
		elsif
			@novels = Novel.all
		end
	end

	def show
	end

	def edit
	end

	def new
		@novel = Novel.new
	end

	def destroy
	end

	def ranking
	end

	def create
		@novel = Novel.new(novel_params)
		@novel.user_id = current_user.id
		if @novel.save
			flash[:notice] = "一話目を投稿しよう"
			redirect_to new_novel_novel_content_path(@novel.id)
		else
			render action: 'new'
		end
	end

	private
	def novel_params
		params.require(:novel).permit(:novel_title, :novel_about, :tag_list, :genre_id)
	end
end
