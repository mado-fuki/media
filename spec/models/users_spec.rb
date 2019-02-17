require 'rails_helper'

describe 'User', type: :module do
  before do
    @user = FactoryBot.build(:user)
  end

  it 'ユーザー名、メールアドレス、パスワードがあれば有効な状態であること' do
    expect(@user).to be_valid
  end

  it 'ユーザー名がなければ無効な状態であること' do
    @user.name = ''
    expect(@user).not_to be_valid
  end

  it 'メールアドレスがなければ無効な状態であること' do
    @user.email = ''
    expect(@user).not_to be_valid
  end

  it 'パスワードがなければ無効な状態であること' do
    @user.password_digest = ''
    expect(@user).not_to be_valid
  end

  it 'ユーザー名が50文字より長ければ無効な状態であること' do
    @user.name = 'a' * 51
    expect(@user).not_to be_valid
  end

  it 'メールアドレスが255文字より長ければ無効な状態であること' do
    @user.email = 'a' * 244 + '@example.com'
    expect(@user).not_to be_valid
  end

  it '重複したメールアドレスなら無効な状態であること' do
    user_with_same_email = @user.dup
    user_with_same_email.save
    expect(@user).not_to be_valid
  end

  it 'パスワードが空文字なら無効な状態であること' do
    @user.password = @user.password_confirmation = ' ' * 8
    expect(@user).not_to be_valid
  end

  it 'パスワードが8文字未満なら無効な状態であること' do
    @user.password = @user.password_confirmation = 'a' * 7
    expect(@user).not_to be_valid
  end
end
