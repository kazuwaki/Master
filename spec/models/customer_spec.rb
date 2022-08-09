# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'customerモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { customer.valid? }

    let!(:other_customer) { create(:customer) }
    let(:customer) { build(:customer) }

    context 'nameカラム' do
      it '空欄でないこと' do
        customer.name = ''
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '50文字以下であること: 50文字は〇' do
        customer.introduction = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end
