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

      #it '投稿一覧を押すと、投稿一覧に遷移する' do
        #post_link = find_all('a')[1].native.inner_text
        #post_link = post_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        #click_link post_link
        #is_expected.to eq '/posts'
      #end
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
      #it 'タイムラインを押すと、タイムライン一覧画面に遷移する' do
        #time_line_link = find_all('a')[4].native.inner_text
        #time_line_link = time_line_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        #click_link time_line_link
        #is_expected.to eq '/time_lines'
      #end
    end
  end
end