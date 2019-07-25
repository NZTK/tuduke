# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Userに関するテスト', type: :feature do
  before do

    create(:genre)
    @user1 = create(:user, :create_with_novels, :create_with_novel_contents)
    @user2 = create(:user, :create_with_novels, :create_with_novel_contents)
  end
  feature 'ログインしていない状態で' do
    feature '以下のページへアクセスした際のリダイレクト先の確認' do
      scenario 'userの編集ページ' do
        visit edit_user_path(@user1)
        expect(page).to have_current_path new_user_session_path
      end
    end
  end

  feature 'ログインした状態で' do
    before do
      login(@user1)
    end
    feature '表示内容とリンクの確認' do
      scenario '自分の詳細ページの表示内容とリンク' do
        visit user_path(@user1)
        expect(page).to have_content @user1.username
        expect(page).to have_link '', href: edit_user_path(@user1)
        @user1.novels.each do |n|
          expect(page).to have_link n.novel_title, href: novel_path(n)
          expect(page).to have_content n.novel_about
        end

        @user1.novel_contents.each do |nc|
          expect(page).to have_link nc.novel_content_title, href: novel_novel_content_path(nc.novel, nc)
          expect(page).to have_link nc.novel.novel_title, href: novel_path(nc.novel)
          expect(page).to have_link nc.user.username, href: user_path(nc.user)
          expect(page).to have_link nc.novel.user.username, href: user_path(nc.novel.user)
        end
      end

      scenario '他人の詳細ページの表示内容とリンク' do
        visit user_path(@user2)
        expect(page).to have_content @user2.username

        @user2.novels.each do |n|
          expect(page).to have_link n.novel_title, href: novel_path(n)
          expect(page).to have_content n.novel_about
        end

        @user2.novel_contents.each do |nc|
          expect(page).to have_link nc.novel_content_title, href: novel_novel_content_path(nc.novel, nc)
          expect(page).to have_link nc.novel.novel_title, href: novel_path(nc.novel)
          expect(page).to have_link nc.user.username, href: user_path(nc.user)
          expect(page).to have_link nc.novel.user.username, href: user_path(nc.novel.user)
        end
      end
    end

    feature '自分のプロフィールの更新' do
      before do
        visit edit_user_path(@user1)
        find_field('user[username]').set('updated_name')
        find("input[value='更新']").click
      end
      scenario 'userが更新されているか' do
        expect(page).to have_content 'updated_name'
      end
      scenario 'リダイレクト先は正しいか' do
        expect(page).to have_current_path user_path(@user1)
      end
      scenario 'サクセスメッセージが表示されるか' do
        expect(page).to have_content 'を更新しました'
      end
    end

    feature '他人のプロフィールの更新' do
      scenario 'ページへアクセスできず、リダイレクトされるか' do
        visit edit_user_path(@user2)
        expect(page).to have_current_path user_path(@user2)
      end
    end

    feature '有効ではない内容のuserの更新' do
      before do
        visit edit_user_path(@user1)
        find_field('user[username]').set(nil)
        find("input[value='更新']").click
      end
      scenario 'リダイレクト先が正しいか' do
        expect(page).to have_current_path user_path(@user1)
      end

    end
  end
end
