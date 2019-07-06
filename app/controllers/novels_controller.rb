class NovelsController < ApplicationController

	def index
		if params[:tag]
			@novels = Novel.tagged_with(params[:tag])
		else
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
		if @novel.save
			flash[:notice] = "一話目を投稿しよう"
			redirect_to new_novel_novel_content_path(params[:id])
		else
			render action: 'new'
		end
	end

	private
	def novel_params
		params.require(:novel).permit(:novel_title, :novel_about, :tag_list)
	end
end
