require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:customer) { create(:customer) }
  let!(:other_customer) { create(:customer) }

  before do
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      it '投稿一覧を押すと、投稿一覧に遷移する' do
        post_link = find_all('a')[1].native.inner_text
        post_link = post_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link post_link, match: :first
        is_expected.to eq '/posts'
      end
      it 'ユーザーを押すと、ユーザー一覧画面に遷移する' do
        customer_link = find_all('a')[3].native.inner_text
        customer_link = customer_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link customer_link
        is_expected.to eq '/customers'
      end
      it 'マイページを押すと、ログインユーザー詳細画面に遷移する' do
        customers_link = find_all('a')[2].native.inner_text
        customers_link = customers_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link customers_link
        is_expected.to eq '/customers/' + customer.id.to_s
      end
      it '診断を押すと診断チャートに遷移する' do
        about_link = find_all('a')[5].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
      it 'タイムラインを押すと、タイムライン一覧画面に遷移する' do
        time_lines_link = find_all('a')[4].native.inner_text
        time_lines_link = time_lines_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link time_lines_link, match: :first
        is_expected.to eq '/time_lines'
      end
    end
  end
  describe 'ユーザ一覧画面のテスト' do
    before do
      visit customers_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers'
      end
      it '自分と他人の名前がそれぞれ表示される' do
        expect(page).to have_content customer.name
        expect(page).to have_content other_customer.name
      end
      it '自分と他人の名前がそれぞれ表示される' do
        expect(page).to have_content customer.introduction
        expect(page).to have_content other_customer.introduction
      end
    end
  end
  describe 'ユーザー詳細ページのテスト' do
    before do
      visit customer_path(customer)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/'  + customer.id.to_s
      end
      it '自分の名前と自己紹介がそれぞれ表示される' do
        expect(page).to have_content customer.name
        expect(page).to have_content customer.introduction
      end
      it '「編集」が表示されている' do
        expect(page).to have_content '編集'
      end
    end
  end
  describe 'ユーザー編集ページのテスト' do
    before do
      visit edit_customer_path(customer)
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/'  + customer.id.to_s + '/edit'
      end
      it '編集前のnameとintroductionが表示(セット)されている' do
        expect(page).to have_field 'customer[name]', with: customer.name
        expect(page).to have_field 'customer[introduction]', with: customer.introduction
      end
      it '更新内容を内容を保存が表示される' do
        expect(page).to have_button '内容を保存'
      end
      context '更新処理に関するテスト' do
        it '更新後のリダイレクト先は正しいか' do
          fill_in 'customer[name]', with: Faker::Lorem.characters(number:5)
          fill_in 'customer[introduction]', with: Faker::Lorem.characters(number:20)
          click_button '内容を保存'
          expect(page).to have_current_path customer_path(customer)
        end
      end
    end
  end
end