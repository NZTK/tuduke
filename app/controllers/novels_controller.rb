class NovelsController < ApplicationController
	before_action :authenticate_user! ,only: [:edit, :new]
	before_action :correct_user ,only: [:edit]


	def index
		if params[:tag_name]
			puts 'tag_name'
			@novels = Novel.page(params[:page]).tagged_with(params[:tag_name])
			@novel_contents = NovelContent.where(novel_id: @novels)
			@likes = Like.where(novel_content_id: @novel_contents)
		elsif params[:genre_id]
			puts 'gnere_id'
			@novels = Novel.page(params[:page]).where(genre_id: params[:genre_id])
			@novel_contents = NovelContent.where(novel_id: @novels)
			@likes = Like.where(novel_content_id: @novel_contents)
		else
			puts 'other'
			@search = Novel.ransack(params[:q])
			@search_novels = @search.result.page(params[:page])
			# @paginatable_array = Kaminari.paginate_array(@search_novels).page(params[:page])
			# @novel_contents = NovelContent.where(novel_id: @search_novels)
			# @likes = Like.where(novel_content_id: @novel_contents)
			# @search_novels.each do |f|
			# 	binding.pry
			# 	@likes = Like.where(novel_content_id: f.novel_content)
			# 	@comments = Comment.where(novel_content_id: f.novel_content)

			# end
		end


	end

	def show
		@novel =  Novel.find(params[:id])
		@novel_contents = NovelContent.where(novel_id:  params[:id])
		impressionist(@novel, nil, :unique => [:session_hash])
	end

	def edit
		@novel = Novel.find(params[:id])
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
			flash[:notice] = "一話目を投稿しよう！"
			redirect_to new_novel_novel_content_path(@novel.id)
		else
			render action: 'new'
		end
	end

	def update
		@novel = Novel.find(params[:id])
		if  @novel.update(novel_params)
			flash[:notice] = "更新しました"
		    redirect_to novel_path(@novel)
		else
			render action: "edit"
		end
	end

	private
	def novel_params
		params.require(:novel).permit(:novel_title, :novel_about, :tag_list, :genre_id)
	end

	def correct_user
		@novel = Novel.find(params[:id])
		if current_user.admin  || current_user.id == @novel.user_id
		   	render :edit
		else
			flash[:alert] = "権限がありません"
		   	redirect_to root_path
		end
	end
end
