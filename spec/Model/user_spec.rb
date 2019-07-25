require 'rails_helper'

RSpec.describe User, type: :model do
  # describe 'アソシエーション' do
  #      it 'Novelモデルを多数持っている' do
  #        is_expected.to have_many(:novel)
  #      end
  #      it 'NovelContentモデルを多数持っている' do
  #        is_expected.to have_many(:novel_content)
  #      end
  #    end

  describe "会員登録してみる" do
    context '新規会員登録ができる' do
      it "ユーザー登録できる" do
        expect(FactoryBot.create(:user)).to be_valid
      end
    end
    context '会員登録ができない' do
      it "usernameが空欄" do
        user = build(:user, :no_username)
        user.valid?
        expect(user.errors[:username]).to include("を入力してください", "は3文字以上で入力してください")
      end
      it "usernameが3文字以下" do
        user = build(:user, :too_short_username)
        user.valid?
        expect(user.errors[:username]).to include("は3文字以上で入力してください")
      end

      it "usernameが15文字以上" do
        user = build(:user, :too_long_username)
        user.valid?
        expect(user.errors[:username]).to include("は15文字以内で入力してください")
      end
    end
  end
end
