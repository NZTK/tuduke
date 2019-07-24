require 'rails_helper'

RSpec.feature 'NovelContentに関するテスト', type: :feature do
  before do
    genre = create(:genre)
    @user1 = create(:user, :create_with_novels, :create_with_novel_contents)
    @user2 = create(:user, :create_with_novels, :create_with_novel_contents)
  end

  feature '非ログイン状態で' do
    feature '以下のページへのアクセス時のリダイレクト先' do
      scenario 'novel_contentの編集ページ' do
        visit edit_novel_novel_content_path(@user1.novel_contents.first.novel, @user1.novel_contents.first)
        expect(page).to have_current_path new_user_session_path
      end

      scenario 'novel_contentの新規投稿ページ' do
        novel = Novel.find(1)
        visit new_novel_novel_content_path(novel)
        expect(page).to have_current_path new_user_session_path
      end
    end
  end
  feature 'ログイン状態で' do
    before do
      login(@user1)
    end
    feature '表示内容とリンクの確認' do
      scenario '自分の投稿したnovel_contentの詳細ページ' do
        novel = Novel.find(1)
        novel_content = @user1.novel_contents.first
        visit novel_novel_content_path(novel, novel_content)
        expect(page).to have_content novel.novel_title
        expect(page).to have_content novel.user.username
        expect(page).to have_content novel_content.user.username
        expect(page).to have_content novel_content.novel_content_title
        expect(page).to have_content novel_content.novel_content_text
        expect(page).to have_content novel_content.novel_content_forewords
        expect(page).to have_content novel_content.novel_content_afterwords
        expect(page).to have_link '', href: user_path(novel.user)
        expect(page).to have_link '', href: user_path(novel_content.user)
        expect(page).to have_link '', href: novel_path(novel)
        expect(page).to have_link '', href: edit_novel_novel_content_path(novel, novel_content)
      end
      scenario '他人の投稿したnovel_contentの詳細ページ' do
        novel = Novel.find(1)
      	novel_content = @user2.novel_contents.first
      	visit novel_novel_content_path(novel, novel_content)
      	expect(page).to have_content novel.novel_title
        expect(page).to have_content novel.user.username
        expect(page).to have_content novel_content.user.username
        expect(page).to have_content novel_content.novel_content_title
        expect(page).to have_content novel_content.novel_content_text
        expect(page).to have_content novel_content.novel_content_forewords
        expect(page).to have_content novel_content.novel_content_afterwords
        expect(page).to have_link '', href: user_path(novel.user)
        expect(page).to have_link '', href: user_path(novel_content.user)
        expect(page).to have_link '', href: novel_path(novel)
      end
    end


    feature '自分の投稿したnovel_contentの編集' do
    	before do
        novel = Novel.find(1)
    		novel_content = @user1.novel_contents.first
    		visit edit_novel_novel_content_path(novel, novel_content)
    		find_field('novel_content[novel_content_title]').set('update_title_a')
        find_field('novel_content[novel_content_forewords]').set('update_forewords_b')
        find_field('novel_content[novel_content_afterwords]').set('update_afterwords_c')
    		find_field('novel_content[novel_content_text]').set('update_text_d_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa')
    		find("input[value='更新']").click
        end
      scenario '更新されているか' do
      	expect(page).to have_content 'update_title_a'
        expect(page).to have_content 'update_forewords_b'
        expect(page).to have_content 'update_afterwords_c'
      	expect(page).to have_content 'update_text_d_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      end
      scenario 'リダイレクト先は正しいか' do
      	expect(page).to have_current_path  novel_novel_content_path(@user1.novel_contents.first.novel, @user1.novel_contents.first)
      end
      scenario 'サクセスメッセージの表示' do
      	expect(page).to have_content '更新しました'
      end
    end


    feature '他人の投稿したnovel_contentの編集' do
    	scenario 'アクセス不可かつリダイレクトされるか' do
    		visit edit_novel_novel_content_path(Novel.find(1), @user2.novel_contents.first)
    		expect(page).to have_current_path novel_novel_content_path(Novel.find(1), @user2.novel_contents.first)
    	end
    end


    feature '有効ではない内容のnovel_contentの更新' do
      before do
        novel = Novel.find(1)
        novel_content = @user1.novel_contents.first
        visit edit_novel_novel_content_path(novel, novel_content)
        find_field('novel_content[novel_content_title]').set(nil)
        find("input[value='更新']").click
      end
      scenario 'リダイレクト先は正しいか' do
        expect(page).to have_current_path novel_novel_content_path(@user1.novel_contents.first.novel, @user1.novel_contents.first)
      end
    end
  end
end
