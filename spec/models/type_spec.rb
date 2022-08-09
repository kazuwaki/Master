# frozen_string_literal: true

require 'rails_helper'

describe 'Typeモデルのテスト' do
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:type)).to be_valid
  end
  describe 'バリデーションのテスト' do
    subject { type.valid? }

    let!(:other_type) { create(:type) }
    let(:type) { build(:type) }

    context 'nameカラム' do
      it '空欄でないこと' do
        type.name = ''
        is_expected.to eq false
      end
    end 
  end
end