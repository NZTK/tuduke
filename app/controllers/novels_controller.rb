class NovelsController < ApplicationController

	def index
		@novels = Novel.all
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
	end

	private
	def
	end
end
end