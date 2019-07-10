class NovelContentsController < ApplicationController
	def new
		@novel = Novel.find_by(id: params[:novel_id])
		@novel_content = NovelContent.new
	end

	def show
		@novel_content = NovelContent.find(params[:id])
		@novel = Novel.find_by(id: @novel_content.novel.id)
	end

	def create
		@novel  = Novel.find_by(id: params[:novel_id])
		@novel_content = NovelContent.new(novel_content_params)
		@novel_content.user_id = current_user.id
		@novel_content.novel_id = @novel.id
		if @novel_content.save
			redirect_to novel_path(@novel.id)
		else
			render action: 'new'
		end
	end

	def edit
	end

	def destroy
	end
end

private
def novel_content_params
	params.require(:novel_content).permit(:novel_content_title, :novel_content_text, :novel_content_forewords, :novel_content_afterwords)
end
