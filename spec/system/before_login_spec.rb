require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
    describe 'ヘッダーのテスト: ログインしていない場合' do
      subject { current_path }
      it '新規登録を押すと、新規登録画面に遷移する' do
        sign_up_link = find_all('a')[1].native.inner_text
        expect(sign_up_link).to match(/新規登録/)
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        sign_in_link = find_all('a')[2].native.inner_text
        expect(sign_in_link).to match(/ログイン/)
      end
      it 'Topを押すと、ホーム画面に遷移する' do
        home_link = find_all('a')[3].native.inner_text
        expect(home_link).to match(/Top/)
      end
      it '診断を押すと診断チャートに遷移する' do
        about_link = find_all('a')[4].native.inner_text
        expect(about_link).to match(/診断/)
      end
    end
    describe '新規登録画面のテスト' do
      before do
        visit new_customer_registration_path
      end
      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/customers/sign_up'
        end
        it '「新規登録」と表示される' do
          expect(page).to have_content '新規登録'
        end
        it 'nameフォームが表示される' do
          expect(page).to have_field 'customer[name]'
        end
        it 'emailフォームが表示される' do
          expect(page).to have_field 'customer[email]'
        end
        it 'passwordフォームが表示される' do
          expect(page).to have_field 'customer[password]'
        end
        it 'password_confirmationフォームが表示される' do
          expect(page).to have_field 'customer[password_confirmation]'
        end
        it '新規登録ボタンが表示される' do
          expect(page).to have_button '新規登録'
        end
        it 'ログインリンクが表示される' do
          expect(page).to have_link 'ログイン'
        end
        it 'ゲストユーザーリンクが表示される' do
          expect(page).to have_link 'ゲストログイン'
        end
      end
      context '新規登録成功のテスト' do
        before do
          fill_in 'customer[name]', with: Faker::Lorem.characters(number: 10)
          fill_in 'customer[email]', with: Faker::Internet.email
          fill_in 'customer[password]', with: 'password'
          fill_in 'customer[password_confirmation]', with: 'password'
        end

        it '正しく新規登録される' do
          expect { click_button '新規登録' }.to change(Customer.all, :count).by(1)
        end
        it '新規登録後のリダイレクト先が、Top画面になっている' do
          click_button '新規登録'
          expect(current_path).to eq '/'
        end
      end
    end
    describe 'ログイン画面のテスト' do
      let(:customer) { create(:customer) }

      before do
        visit new_customer_session_path
      end
      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/customers/sign_in'
        end
        it '「ログイン」と表示される' do
          expect(page).to have_content '新規登録'
        end
        it 'emailフォームが表示される' do
          expect(page).to have_field 'customer[email]'
        end
        it 'passwordフォームが表示される' do
          expect(page).to have_field 'customer[password]'
        end
        it 'ログインボタンが表示される' do
          expect(page).to have_button 'ログイン'
        end
        it '新規登録リンクが表示される' do
          expect(page).to have_link 'ログイン'
        end
        it 'ゲストユーザーリンクが表示される' do
          expect(page).to have_link 'ゲストログイン'
        end
      end
      context 'ログイン成功のテスト' do
        before do
          fill_in 'customer[email]', with: customer.email
          fill_in 'customer[password]', with: customer.password
          click_button 'ログイン'
        end

        it 'ログイン後のリダイレクト先が、Top画面になっている' do
          expect(current_path).to eq '/'
        end
      end
      context 'ログイン失敗のテスト' do
        before do
          fill_in 'customer[email]', with: ' '
          fill_in 'customer[password]', with: ' '
          click_button 'ログイン'
        end

        it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
          expect(current_path).to eq '/customers/sign_in'
        end
      end
    end
  end
end