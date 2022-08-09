# frozen_string_literal: true

require 'rails_helper'

describe 'Alcoholモデルのテスト' do
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:alcohol)).to be_valid
  end
  describe 'バリデーションのテスト' do
    subject { alcohol.valid? }

    let!(:other_alcohol) { create(:alcohol) }
    let(:alcohol) { build(:alcohol) }

    context 'nameカラム' do
      it '空欄でないこと' do
        alcohol.name = ''
        is_expected.to eq false
      end
    end 
  end
end