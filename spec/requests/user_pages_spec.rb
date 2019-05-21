require 'spec_helper'

describe 'User pages' do

  subject { page }
 
  describe 'signup' do

    before { visit signup_path }

    let(:submit) { '新規登録' }

    context '無効な情報の場合' do
      it 'ユーザーが作成されないこと' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    context '有効な情報の場合' do
      before do
        fill_in 'user_name',         with: 'Example User'
        fill_in 'user_email',        with: 'user@example.com'
        fill_in 'password',     with: 'foobar'
        fill_in 'user_password_confirmation', with: 'foobar'
      end

      it 'ユーザーが作成されること' do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end

    describe "失敗時のエラーメッセージ" do
      context "after submission", js: true do
        before { click_button submit }
        
        it 'aa' do
          is_expected.to have_title('新規登録')
        end
      end
    end
  end
end