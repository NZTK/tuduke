class NovelsController < ApplicationController
	def index
		if params[:tag_name]
			puts 'tag_name'
			@novels = Novel.tagged_with(params[:tag_name])
		elsif params[:genre_id]
			puts 'gnere_id'
			@novels = Novel.where(genre_id: params[:genre_id])
		else
			puts 'other'
			@novels = Novel.all
		end

	end

	def show
		@novel =  Novel.find(params[:id])
		
		@novel_contents = NovelContent.where(novel_id:  params[:id])
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
