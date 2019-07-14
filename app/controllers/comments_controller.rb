class CommentsController < ApplicationController

	def create
		@novel_content = NovelContent.find(params[:novel_content_id])
		@novel = Novel.find_by(id: @novel_content.novel_id)
		@comment = @novel_content.comments.new(comment_params)
		@comment.novel_content_id = @novel_content.id
		@comment.user_id = current_user.id
		if @comment.save
			render :index
		end
	end

	def destroy
		@novel_content = NovelContent.find(params[:novel_content_id])
		@comment = Comment.find(params[:id])
		if @comment.destroy
			render :index
		end
	end

end

private
def comment_params
	params.require(:comment).permit(:comment_contents, :user_id, :novel_content_id)
end