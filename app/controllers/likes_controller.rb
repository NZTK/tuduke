class LikesController < ApplicationController

	def create
		@novel_content = NovelContent.find(params[:novel_content_id])
		@novel = @novel_content.novel
		@like = current_user.likes.new(novel_content_id: @novel_content.id)
		@like.save
		redirect_to novel_novel_content_path(@novel, @novel_content)
	end

	def destroy
		@novel_content = NovelContent.find(params[:novel_content_id])
		@novel = @novel_content.novel
		@like = current_user.likes.find_by(novel_content_id: @novel_content.id)
		@like.destroy
		redirect_to novel_novel_content_path(@novel, @novel_content)
	end
end
