require 'rails_helper'

describe '[STEP2] 管理者ログイン後のテスト' do
  let(:admin) { create(:admin) }
  let(:customer) { create(:customer) }
  let!(:other_customer) { create(:customer) }
  let!(:time_line) { create(:time_line, customer: customer) }
  let!(:other_time_line) { create(:time_line, customer: other_customer) }
  let!(:type) { create(:type) }
  let!(:alcohol) { create(:alcohol) }

  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'ログイン'
  end
  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      it '投稿一覧を押すと、投稿一覧に遷移する' do
        post_link = find_all('a')[1].native.inner_text
        post_link = post_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link post_link, match: :first
        is_expected.to eq '/admin/posts'
      end
      it 'タイムラインを押すと、タイムライン一覧画面に遷移する' do
        time_lines_link = find_all('a')[2].native.inner_text
        time_lines_link = time_lines_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link time_lines_link, match: :first
        is_expected.to eq '/admin/time_lines'
      end
      it 'Typeを押すと、Type画面に遷移する' do
        type_link = find_all('a')[3].native.inner_text
        type_link = type_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link type_link
        is_expected.to eq '/admin/types'
      end
      it 'Alcoholを押すと、Alcohol画面に遷移する' do
        customers_link = find_all('a')[4].native.inner_text
        customers_link = customers_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link customers_link
        is_expected.to eq '/admin/alcohols'
      end
    end
  end
  describe '投稿一覧画面のテスト' do
    before do
      visit admin_posts_path
    end
    it 'URLが正しく表示される' do
      expect(current_path).to eq '/admin/posts'
    end
  end
  describe 'タイムライン一覧画面のテスト' do
    before do
      visit admin_time_lines_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/time_lines'
      end
      it 'タイムライン投稿者のnameが表示されているか' do
        expect(page).to have_content time_line.customer.name
        expect(page).to have_content other_time_line.customer.name
      end
      it 'タイムラインのtitleが表示されているか' do
        expect(page).to have_content time_line.title
        expect(page).to have_content other_time_line.title
      end
      it 'タイムラインのbodyが表示されているか' do
        expect(page).to have_content time_line.body
        expect(page).to have_content other_time_line.body
      end
      it 'タイムラインのShowが表示されているか' do
        expect(page).to have_link 'show', href: admin_time_line_path(time_line)
        expect(page).to have_link 'show', href: admin_time_line_path(other_time_line)
      end
      it 'タイムラインのdeleteが表示されているか' do
        expect(page).to have_link 'delete', href: admin_time_lines_path
        expect(page).to have_link 'delete', href: admin_time_lines_path
      end
    end
  end
  describe 'タイプの一覧画面のテスト' do
    before do
      visit admin_types_path
    end
    context '表示内容の確認' do
      it 'URLが正しく表示される' do
        expect(current_path).to eq '/admin/types'
      end
      it 'typeのidが表示されているか' do
        expect(page).to have_content type.id
      end
      it 'typeのnameが表示されているか' do
        expect(page).to have_content type.name
      end
      it 'typeの編集が表示されているか' do
        expect(page).to have_link '編集', href: edit_admin_type_path(type)
      end
      it 'nameフォームが表示されている' do
        expect(page).to have_field 'type[name]'
      end
      it 'nameフォームに値が入っていない' do
        expect(find_field('type[name]').text).to be_blank
      end
      it '登録ボタンが表示されている' do
        expect(page).to have_button "登録"
      end
    end
    context 'type登録成功のテスト' do
      before do
        fill_in 'type[name]', with: Faker::Lorem.characters(number: 10)
      end
      #it 'typeの新規登録が正しく保存される' do
       # expect { click_button '登録' }.to change(admin.types, :count).by(1)
      #end
      it 'リダイレクト先が、遷移元画面になっている' do
        click_button '登録'
        expect(current_path).to eq '/admin/types'
      end
    end
  end
  describe 'タイプの変更画面のテスト' do
    before do
      visit edit_admin_type_path(type)
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/types/' + type.id.to_s + '/edit'
      end
      it '編集前のタイプ名が表示されている' do
        expect(page).to have_field 'type[name]', with: type.name
      end
      it '変更内容を保存が表示されている' do
        expect(page).to have_button '更新内容を保存'
      end
    end
    context '変更処理に関するテスト' do
      before do
        @type_old_name = type.name
        fill_in 'type[name]', with: Faker::Lorem.characters(number:5)
        click_button '更新内容を保存'
      end
      it 'nameが正しく更新できている' do
        expect(type.reload.name).not_to eq @type_old_name
      end
      it '保存したら一覧画面にリダイレクトされる' do
        expect(current_path).to eq '/admin/types'
      end
    end
  end
  describe 'アルコールの一覧画面のテスト' do
    before do
      visit admin_alcohols_path
    end
    context '表示内容の確認' do
      it 'URLの確認' do
        expect(current_path).to eq '/admin/alcohols'
      end
      it 'アルコールのidが表示されている' do
        expect(page).to have_content alcohol.id
      end
      it 'アルコールの名前が表示されている' do
        expect(page).to have_content alcohol.name
      end
      it '編集が表示されている' do
        expect(page).to have_link '編集', href: edit_admin_alcohol_path(alcohol)
      end
      it 'nameフォームが表示されている' do
        expect(page).to have_field 'alcohol[name]'
      end
      it 'nameフォームに値が入っていない' do
        expect(find_field('alcohol[name]').text).to be_blank
      end
      it '登録ボタンが表示されている' do
        expect(page).to have_button "登録"
      end
    end
    context 'alcohol登録成功のテスト' do
      before do
        fill_in 'alcohol[name]', with: Faker::Lorem.characters(number: 10)
      end
      it 'リダイレクト先が、遷移元画面になっている' do
        click_button '登録'
        expect(current_path).to eq '/admin/alcohols'
      end
    end
  end
end