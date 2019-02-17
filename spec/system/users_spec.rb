require 'rails_helper'

describe 'ログイン機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'ログイン(仮)' do
    visit '/login'
    fill_in 'session_email', with: 'test1@example.com'
    fill_in 'session_password', with: 'password'
    click_button 'ログイン'
  end
end