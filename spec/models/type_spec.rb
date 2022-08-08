# frozen_string_literal: true

require 'rails_helper'

describe 'Typeモデルのテスト' do
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:type)).to be_valid
  end
end