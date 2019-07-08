class NovelContentsController < ApplicationController
	def new
		@novel_content = NovelContent.new
		@novel  =  Novel.find_by(params[:id])
	end

	def show
	end

	def create
	end

	def edit
	end

	def destroy
	end
end
