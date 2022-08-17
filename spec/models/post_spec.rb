# frozen_string_literal: true

require "rails_helper"

RSpec.describe "postモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { post.valid? }

    let!(:other_post) { create(:post) }
    let(:post) { build(:post) }

    context "nameカラム" do
      it "空欄でないこと" do
        post.name = ""
        is_expected.to eq false
      end
    end
    context "bodyカラム" do
      it "空欄でないこと" do
        post.body = ""
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Customerモデルとの関係" do
      it "N:1となっている" do
        expect(Post.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end
end
