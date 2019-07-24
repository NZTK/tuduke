require 'rails_helper'

RSpec.describe NovelContent, type: :model do
	describe "新規投稿してみる" do
		context "投稿できる" do
			it "全部入力されている" do
				user = create(:user)
				genre = create(:genre)
				novel =  create(:novel, user_id:  user.id, genre_id: genre.id)

				expect(create(:novel_content, user_id: user.id, novel_id: novel.id)).to be_valid
			end
		end
		context "投稿できない" do
			it "user_idが空欄" do
				genre = create(:genre)
				user = create(:user)
				novel = create(:novel, user_id: user.id, genre_id: genre.id)
				novel_content = build(:novel_content, novel_id: novel.id)
				novel_content.valid?
				expect(novel_content.errors[:user]).to include("を入力してください")
			end
			it "novel_idが空欄" do
				user = create(:user)
				novel_content = build(:novel_content, user_id: user.id)
				novel_content.valid?
				expect(novel_content.errors[:novel]).to include("を入力してください")
			end
			it "novel_content_titleが空欄" do
				user = create(:user)
				genre = create(:genre)
				novel = create(:novel, user_id: user.id, genre_id: genre.id)
				novel_content = build(:novel_content, :no_content_title, user_id: user.id, novel_id: novel.id)
				novel_content.valid?
				expect(novel_content.errors[:novel_content_title]).to include("を入力してください")
			end
			it "novel_content_titleが50文字以上" do
				user = create(:user)
				genre = create(:genre)
				novel = create(:novel, user_id: user.id, genre_id: genre.id)
				novel_content = build(:novel_content, :too_long_content_title, user_id: user.id, novel_id: novel.id)
				novel.valid?
				expect(novel_content.errors.messages).to include()
			end
			it "novel_content_textが空欄" do
				user = create(:user)
				genre = create(:genre)
				novel = create(:novel, user_id: user.id, genre_id: genre.id)
				novel_content = build(:novel_content, :no_text, user_id: user.id, novel_id: novel.id)
				novel_content.valid?
				expect(novel_content.errors).to include()
			end
			it "novel_content_textが300文字以下" do
				user = create(:user)
				genre = create(:genre)
				novel = create(:novel, user_id: user.id, genre_id: genre.id)
				novel_content = build(:novel_content, :too_short_text, user_id: user.id, novel_id: novel.id)
				novel_content.valid?
				expect(novel_content.errors[:novel_content_text]).to include("は300文字以上で入力してください")
			end
			it "novel_content_textが50000文字以上" do
				user = create(:user)
				genre = create(:genre)
				novel = create(:novel, user_id: user.id, genre_id: genre.id)
				novel_content = build(:novel_content, :too_long_text, user_id: user.id, novel_id: novel.id)
				novel_content.valid?
				expect(novel_content.errors[:novel_content_text]).to include("は50000文字以内で入力してください")
			end
			it "novel_content_forewordsが500文字以上" do
				user = create(:user)
				genre = create(:genre)
				novel = create(:novel, user_id: user.id, genre_id: genre.id)
				novel_content = build(:novel_content, :too_long_forewords, user_id: user.id, novel_id: novel.id)
				novel_content.valid?
				expect(novel_content.errors[:novel_content_forewords]).to include("は500文字以内で入力してください")
			end
			it "novel_content_afterwordsが500文字以上" do
				user = create(:user)
				genre = create(:genre)
				novel = create(:novel, user_id: user.id, genre_id: genre.id)
				novel_content = build(:novel_content, :too_long_afterwords, user_id: user.id, novel_id: novel.id)
				novel_content.valid?
				expect(novel_content.errors[:novel_content_afterwords]).to include("は500文字以内で入力してください")
			end
		end
	end
end