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
       it '「編集」が表示されている' do
        expect(page).to have_content '編集'
      end
      it '「新規登録」が表示されている' do
        expect(page).to have_content '新規登録'
      end
    end
    describe '編集画面のテスト' do
      before do
        visit edit_admin_alcohol_path(alcohol)
      end
      context '表示の確認' do
        it '編集前のnameが表示(セット)されている' do
          expect(page).to have_field 'alcohol[name]', with: alcohol.name
        end
        it '更新内容を保存ボタンが表示される' do
          expect(page).to have_button '更新内容を保存'
        end
      end
      context '更新処理に関するテスト' do
        it '更新後のリダイレクト先は正しいか' do
          fill_in 'type[name]', with: Faker::Lorem.characters(number:5)
          click_button '更新内容を保存'
          expect(page).to have_current_path admin_alcohols_path
        end
      end
    end
  end
end