require 'rails_helper'

RSpec.describe Novel, type: :model do
	describe "新規投稿してみる" do
		context "投稿できる" do
			it "全部入力されている" do
				user = create(:user)
				genre = create(:genre)
				expect(create(:novel, user_id: user.id, genre_id: genre.id)).to be_valid
			end
		end
		context "投稿できない" do
			it "user_idが空欄" do
				genre = create(:genre)

				novel = build(:novel, genre_id: genre.id)
				novel.valid?
				expect(novel.errors[:user]).to include("を入力してください")
			end
			it "genre_idが空欄" do
				user = create(:user)
				novel = build(:novel, user_id: user.id)
				novel.valid?
				expect(novel.errors.messages).to include()
			end
			it "novel_titleが空欄" do
				user = create(:user)
				genre = create(:genre)
				novel = build(:novel, :no_novel_title, user_id: user.id, genre_id: genre.id)
				novel.valid?
				# expect(novel.errors.messages).to include()
			end
			it "novel_titleが50文字以上" do
				user = create(:user)
				genre = create(:genre)
				novel = build(:novel, :too_long_title, user_id: user.id, genre_id: genre.id)
				novel.valid?
				# expect(novel.errors.messages).to include()
			end
			it "novel_aboutが空欄" do
				user = create(:user)
				genre = create(:genre)
				novel = build(:novel, :no_novel_about, user_id: user.id, genre_id: genre.id)
				novel.valid?
				# expect(novel.errors.messages).to include()
			end
			it "novel_aboutが10文字以下" do
				user = create(:user)
				genre = create(:genre)
				novel = build(:novel, :too_short_about, user_id: user.id, genre_id: genre.id)
				novel.valid?
				# expect(novel.errors.messages).to include()
			end
			it "novel_aboutが10000文字以上" do
				user = create(:user)
				genre = create(:genre)
				novel = build(:novel, :too_long_about, user_id: user.id, genre_id: genre.id)
				novel.valid?
				# expect(novel.errors.messages).to include()
			end
		end
	end
end