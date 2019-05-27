# require 'spec_helper'

# describe 'ログイン', type: :system, js: true do
#   subject { page }
#   before { visit login_path }
#   let(:user){ FactoryBot.create(:user)}
#   let(:submit) { 'ログイン' }

#   context "有効な情報の場合" do
#     before do
#       fill_in 'session_email', with: user.email
#       fill_in 'session_password', with: user.password
#     end

#     it 'ユーザーページに遷移すること' do
#       click_button submit
#       is_expected.to have_title(user.name)
#     end
#   end

#   context "無効な情報の場合" do
#     describe "失敗時にエラーメッセージが表示されること" do
#       let(:email_js_error_msg) { '.session_emailformError > .formErrorContent' }
#       let(:password_js_error_msg) { '.session_passwordformError > .formErrorContent' }

#       context "未入力でsubmitした場合" do
#         before do
#           # ポートフォリオ用にあらかじめ入力されているログイン情報を消す
#           fill_in 'session_email',    with: ''
#           fill_in 'session_password', with: ''
#           click_button submit
#         end
#         it { is_expected.to have_title('ログイン') }
#         it { is_expected.to have_content(email_js_error_msg, '* 必須項目です') }
#         it { is_expected.to have_content(email_js_error_msg, '* メールアドレスが正しくありません') }
#         it { is_expected.to have_content(password_js_error_msg, '* 必須項目です') }
#         it { is_expected.to have_content(password_js_error_msg, '* 6文字以上にしてください') }
#       end

#       context "入力文字数が超過した状態でsubmitした場合" do
#         before do
#           fill_in 'session_email',    with: 'a' * 257
#           fill_in 'session_password', with: 'a' * 13
#           click_button submit
#         end
#         it { is_expected.to have_title('ログイン') }
#         it { is_expected.to have_content(email_js_error_msg, '* 256文字以下にしてください') }
#         it { is_expected.to have_content(password_js_error_msg, '* 12文字以下にしてください') }
#       end
#     end
#   end
# end