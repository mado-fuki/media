# require 'spec_helper'

# describe 'ログアウト', type: :system, js: true do
#   subject { page }
#   before do
#     @user = FactoryBot.create(:user)
#     sing_in @user
#     click_link 'navbar-user-toggle'
#     click_link 'ログアウト'
#   end

#   it 'ログインページに遷移すること' do
#     is_expected.to have_title('ログイン')
#   end

#   it 'ヘッダーにログアウトリンクが表示されること' do
#     is_expected.to have_content('nav-link', 'ログイン')
#   end
# end