require 'rails_helper'

RSpec.feature 'Novelに関するテスト', type: :feature do
  before do
    genre = create(:genre)
    @user1 = create(:user, :create_with_novels)
    @user2 = create(:user, :create_with_novels)
  end

  feature '非ログイン状態で' do
    feature '以下のページへのアクセス時のリダイレクト先' do
      scenario 'novelの編集ページ' do
        visit edit_novel_path(@user1.novels.first)
        expect(page).to have_current_path new_user_session_path
      end

      scenario 'novelの新規投稿ページ' do
        visit new_novel_path
        expect(page).to have_current_path new_user_session_path
      end
    end
  end
  feature 'ログイン状態で' do
    before do
      login(@user1)
    end
    feature '表示内容とリンクの確認' do
      scenario '自分の投稿したnovelの詳細ページ' do
        novel = @user1.novels.first
        visit novel_path(novel)
        expect(page).to have_content novel.novel_title
        expect(page).to have_content novel.novel_about
        expect(page).to have_content novel.user.username
        expect(page).to have_link '', href: user_path(novel.user)
        expect(page).to have_link '', href: edit_novel_path(novel)
        expect(page).to have_link '', href: new_novel_novel_content_path(novel)
      end
      scenario '他人の投稿したnovelの詳細ページ' do
      	novel = @user2.novels.first
      	visit novel_path(novel)
      	expect(page).to have_content novel.novel_title
        expect(page).to have_content novel.novel_about
        expect(page).to have_content novel.user.username
        expect(page).to have_link '', href: user_path(novel.user)
        expect(page).to have_link '', href: new_novel_novel_content_path(novel)
      end
    end


    feature '自分の投稿したnovelの編集' do
    	before do
    		novel = @user1.novels.first
    		visit edit_novel_path(novel)
    		find_field('novel[novel_title]').set('update_title_a')
    		find_field('novel[novel_about]').set('update_about_b')
    		find("input[value='更新']").click
        end
      scenario '更新されているか' do
      	expect(page).to have_content 'update_title_a'
      	expect(page).to have_content 'update_about_b'
      end
      scenario 'リダイレクト先は正しいか' do
      	expect(page).to have_current_path  novel_path(@user1.novels.first)
      end
      scenario 'サクセスメッセージの表示' do
      	expect(page).to have_content '更新しました'
      end
    end


    feature '他人の投稿したnovelの編集' do
    	scenario 'アクセス不可かつリダイレクトされるか' do
    		visit edit_novel_path(@user2.novels.first)
    		expect(page).to have_current_path novel_path(@user2.novels.first)
    	end
    end


    feature '有効ではない内容のnovelの更新' do
      before do
        novel = @user1.novels.first
        visit edit_novel_path(novel)
        find_field('novel[novel_title]').set(nil)
        find("input[value='更新']").click
      end
      scenario 'リダイレクト先は正しいか' do
        expect(page).to have_current_path novel_path(@user1.novels.first)
      end
    end




      scenario '一覧ページ' do
      	novels = Novel.all
      	visit root_path
      	novels.each do |n|
	      	expect(page).to have_content n.novel_title
	      	expect(page).to have_content n.novel_about
	      	expect(page).to have_content n.user.username
	      	expect(page).to have_link "", href: novel_path(n)
	      	expect(page).to have_link "", href: user_path(n.user)
        end
      end
    end
end
