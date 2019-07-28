class NovelsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :new, :destroy]
  before_action :correct_user, only: [:edit]
  before_action :user_admin, only: [:novels_admin_index]

  def index
    if params[:tag_name]
      puts 'tag_name'
      @novels = Novel.page(params[:page]).tagged_with(params[:tag_name]).order(created_at: 'desc')
      @novel_contents = NovelContent.where(novel_id: @novels)
      @likes = Like.where(novel_content_id: @novel_contents)
      @tags = Novel.all_tags.order('taggings_count desc')
      @novel_con = NovelContent.all.order(created_at: 'desc')
      @tag = @tags.find_by(name: params[:tag_name])
    elsif params[:genre_id]
      puts 'gnere_id'
      @novels = Novel.page(params[:page]).where(genre_id: params[:genre_id]).order(created_at: 'desc')
      @novel_contents = NovelContent.where(novel_id: @novels)
      @likes = Like.where(novel_content_id: @novel_contents)
      @tags = Novel.all_tags.order('taggings_count desc')
      @novel_con = NovelContent.all.order(created_at: 'desc')
      @genre = Genre.find_by(id: params[:genre_id])
    else
      puts 'other'
      @search = Novel.ransack(params[:q])
      @search_novels = @search.result.page(params[:page]).order(created_at: 'desc')
      @tags = Novel.all_tags.order('taggings_count desc')
      @novel_con = NovelContent.all.order(created_at: 'desc')
      # @paginatable_array = Kaminari.paginate_array(@search_novels).page(params[:page])
      # @novel_contents = NovelContent.where(novel_id: @search_novels)
      # @likes = Like.where(novel_content_id: @novel_contents)
      # @search_novels.each do |f|
      #   binding.pry
      #   @likes = Like.where(novel_content_id: f.novel_content)
      #   @comments = Comment.where(novel_content_id: f.novel_content)

      # end
    end
  end

  def show
    @novel = Novel.find(params[:id])
    @novel_contents = NovelContent.where(novel_id: params[:id])
    impressionist(@novel, nil, :unique => [:session_hash])
  end

  def edit
    @novel = Novel.find(params[:id])
  end

  def new
    @novel = Novel.new
  end

  def destroy
    @novel = Novel.find(params[:id])
    if @novel.destroy
      flash[:alert] = "#{@novel.novel_title}を削除しました"
      redirect_to novels_user_path(@novel.user)
    else
      render action: "edit"
    end
  end

  def novels_admin_index
    @novels = Novel.page(params[:page]).without_deleted
  end

  def ranking
    @like_ranks = NovelContent.find(Like.group(:novel_content_id).order('count(novel_content_id) desc').limit(5).pluck(:novel_content_id))
    @novel_most_viewed = Novel.order('impressions_count desc').limit(3)
    @novel_content_most_viewed = NovelContent.order('impressions_count desc').limit(5)
    @comment_ranks = NovelContent.find(Comment.group(:novel_content_id).order('count(novel_content_id) desc').limit(5).pluck(:novel_content_id))

    # binding.pry
    # @genre_most_viewed = @novel_genre.order('impressions_count desc').limit(3)
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
    if @novel.update(novel_params)
      flash[:notice] = "#{@novel.novel_title}を更新しました"
      redirect_to novel_path(@novel)
    else
      render action: "edit"
    end
  end

  def novel_restore
    @novel = Novel.only_deleted.find(params[:id]).restore
    flash[:notice] = "#{@novel.novel_title}を復元しました"
    redirect_to novels_admin_index_novels_path
  end

  private

  def novel_params
    params.require(:novel).permit(:novel_title, :novel_about, :tag_list, :genre_id)
  end

  def user_admin
    @novels = Novel.page(params[:page]).with_deleted
    if current_user.admin == false
      redirect_to root_path
    else
      render :novels_admin_index
    end
  end

  def correct_user
    @novel = Novel.find(params[:id])
    if current_user.admin || current_user.id == @novel.user_id
      render :edit
    else
      flash[:alert] = "権限がありません"
      redirect_to novel_path(@novel)
    end
  end
end
