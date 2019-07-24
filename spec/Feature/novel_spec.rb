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

			scenario 'novelの投稿ページ' do
				visit new_novel_path
				expect(page).to have_current_path new_user_session_path
			end
		end
	end
	feature 'ログイン状態で' do
		before  do
			login(@user1)
		end
		feature  '表示内容とリンクの確認' do
			scenario '自分の投稿した作品の詳細ページ' do
				novel = @user1.novels.first
				visit novel_path(novel)
				expect(page).to have_content novel.novel_title
				expect(page).to have_content novel.novel_about
				expect(page).to have_content novel.user.username
				expect(page).to have_link '', href: user_path(novel.user)
				expect(page).to have_link '', href: edit_novel_path(novel)
				expect(page).to have_link '', href: new_novel_novel_content_path(novel)
			end
		end
	end

end


