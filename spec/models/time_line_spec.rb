# frozen_string_literal: true

require 'rails_helper'

describe 'TimeLineモデルのテスト' do
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:time_line)).to be_valid
  end
  describe 'バリデーションのテスト' do
    subject { time_line.valid? }

    let!(:other_time_line) { create(:time_line) }
    let(:time_line) { build(:time_line) }

    context 'titleカラム' do
      it '空欄でないこと' do
        time_line.title = ''
        is_expected.to eq false
      end
    end
    context 'bodyカラム' do
      it '空欄でないこと' do
        time_line.body = ''
        is_expected.to eq false
      end
    end
  end
end