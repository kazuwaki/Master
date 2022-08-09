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
      it '「編集」が表示されている' do
        expect(page).to have_content '編集'
      end
      it '「新規登録」が表示されている' do
        expect(page).to have_content '新規登録'
      end
    end
    describe '編集画面のテスト' do
      before do
        visit edit_admin_type_path(type)
      end
      context '表示の確認' do
        it '編集前のnameが表示(セット)されている' do
          expect(page).to have_field 'type[name]', with: type.name
        end
        it '更新内容を保存ボタンが表示される' do
          expect(page).to have_button '更新内容を保存'
        end
      end
      context '更新処理に関するテスト' do
        it '更新後のリダイレクト先は正しいか' do
          fill_in 'type[name]', with: Faker::Lorem.characters(number:5)
          click_button '更新内容を保存'
          expect(page).to have_current_path admin_types_path
        end
      end
    end
  end
end