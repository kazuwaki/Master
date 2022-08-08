# frozen_string_literal: true

require 'rails_helper'

describe 'alcohol投稿のテスト' do
  let!(:alcohol) { create(:alcohol, name:'hoge') }
  describe 'アルコール画面(admin_alcohols_path)のテスト' do
    before do
      visit admin_alcohols_path
    end
    context '表示の確認' do
      it 'アルコール画面(admin_alcohols_path)に「アルコール濃度」が表示されているか' do
        expect(page).to have_content 'アルコール濃度'
      end
      it 'admin_alcohols_pathが"/admin/alcohols"であるか' do
        expect(current_path).to eq('/admin/alcohols')
      end
    end
  end
end