# frozen_string_literal: true

require 'rails_helper'

describe 'Alcoholモデルのテスト' do
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:alcohol)).to be_valid
  end
end