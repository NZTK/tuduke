class NovelContentsController < ApplicationController
	def new
		@novel = Novel.find_by(id: params[:novel_id])
		@novel_content = NovelContent.new
	end

	def show
		@novel_content = NovelContent.find(params[:id])
		@novel = Novel.find_by(id: @novel_content.novel.id)
		new_history =  @novel_content.history.new
		new_history.user_id = current_user.id

		if current_user.histories.exists?(novel_content_id: "#{params[:id]}")
		   old_history = current_user.histories.find_by(novel_content_id: "#{params[:id]}")
		   old_history.destroy
		end

		new_history.save

		if NovelContent.where( "novel_id = ? and id < ?" ,@novel_content.novel.id , @novel_content.id).exists?
			@prev = NovelContent.where('id < ?  and  novel_id = ?', @novel_content.id, @novel_content.novel.id).max
		end
		if NovelContent.where( "novel_id = ? and id > ?" ,@novel_content.novel.id , @novel_content.id).exists?
			@next = NovelContent.where('id > ?  and  novel_id = ?', @novel_content.id, @novel_content.novel.id).min
		end
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
