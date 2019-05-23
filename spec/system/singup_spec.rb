require 'spec_helper'

describe 'ユーザー新規登録', type: :system, js: true do

  subject { page }
  
  before { visit signup_path }

  let(:submit) { '新規登録' }

  context "有効な情報の場合" do
    let(:user_name) { '田中太郎' }
    let(:user_email) { 'test@example.com' }
    let(:password) { 'password' }
    let(:password_confirm) { 'password' }
    before do
      fill_in 'user_name', with: user_name
      fill_in 'user_email', with: user_email
      fill_in 'password', with: password
      fill_in 'user_password_confirmation', with: password_confirm
    end

    it 'ユーザーページに遷移すること' do
      click_button submit
      is_expected.to have_title(user_name)
    end

    it 'ユーザーが作成されること' do
      expect { click_button submit }.to change(User, :count).by(1)
    end
  end

  context "無効な情報の場合" do
    it 'ユーザーが作成されないこと' do
      expect { click_button submit }.not_to change(User, :count)
    end

    describe "失敗時にエラーメッセージが表示されること" do
      let(:name_js_error_msg) { '.user_nameformError > .formErrorContent' }
      let(:email_js_error_msg) { '.user_emailformError > .formErrorContent' }
      let(:password_js_error_msg) { '.passwordformError > .formErrorContent' }
      let(:password_confirm_js_error_msg) { '.user_password_confirmationformError > .formErrorContent' }

      context "未入力でsubmitした場合" do
        before { click_button submit }
        it { is_expected.to have_title('新規登録') }
        it { is_expected.to have_content(name_js_error_msg, '* 必須項目です') }
        it { is_expected.to have_content(email_js_error_msg, '* 必須項目です') }
        it { is_expected.to have_content(email_js_error_msg, '* メールアドレスが正しくありません') }
        it { is_expected.to have_content(password_js_error_msg, '* 必須項目です') }
        it { is_expected.to have_content(password_js_error_msg, '* 6文字以上にしてください') }
        it { is_expected.to have_content(password_confirm_js_error_msg,'* 必須項目です') }
        it { is_expected.to have_content(password_confirm_js_error_msg,'* 6文字以上にしてください') }
      end

      context "入力文字数が超過した状態でsubmitした場合" do
        before do
          fill_in 'user_name',         with: 'a' * 13
          fill_in 'user_email',        with: 'a' * 257
          fill_in 'password',     with: 'a' * 13
          fill_in 'user_password_confirmation', with: 'a' * 13
          click_button submit
        end
        it { is_expected.to have_title('新規登録') }
        it { is_expected.to have_content(name_js_error_msg, '* 12文字以下にしてください') }
        it { is_expected.to have_content(email_js_error_msg, '* 256文字以下にしてください') }
        it { is_expected.to have_content(password_js_error_msg, '* 12文字以下にしてください') }
        it { is_expected.to have_content(password_confirm_js_error_msg ,'* 12文字以下にしてください') }
      end

      context "パスワードとパスワード(確認)の値が一致しなかった場合" do
        before do
          fill_in 'password',     with: 'a' * 6
          fill_in 'user_password_confirmation', with: 'b' * 6
          click_button submit
        end
        it { is_expected.to have_content(password_confirm_js_error_msg ,'* 入力された値が一致しません') }
      end
    end
  end
end