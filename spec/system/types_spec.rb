# frozen_string_literal: true

require 'rails_helper'

describe 'Type投稿のテスト' do
  let!(:type) { create(:type, name:'hoge') }
  describe 'タイプ画面(admin_types_path)のテスト' do
    before do
      visit admin_types_path
    end
    context '表示の確認' do
      it 'タイプ画面(admin_types_path)に「タイプ種類を作成」が表示されているか' do
        expect(page).to have_content 'タイプ種類を作成'
      end
      it 'admin_types_pathが"/admin/types"であるか' do
        expect(current_path).to eq('/admin/types')
      end
    end
  end
end