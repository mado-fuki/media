require 'rails_helper'

describe 'UserModel', type: :module do
  before do
    @user = FactoryBot.build(:user)
  end

  it 'should be valid' do
    expect(@user).to be_valid
  end

  it 'name should be present' do
    @user.name = ''
    expect(@user).not_to be_valid
  end

  it 'email should be present' do
    @user.email = ''
    expect(@user).not_to be_valid
  end

  it 'name should not be too long' do
    @user.name = 'a' * 51
    expect(@user).not_to be_valid
  end

  it 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    expect(@user).not_to be_valid
  end

  it 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    valid_addresses.each do |valid_addresses|
      @user.email = valid_addresses
      expect(@user.email).to match(VALID_EMAIL_REGEX)
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { expect(@user).not_to be_valid }
  end

  it 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 8
    expect(@user).not_to be_valid
  end

  it 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 7
    expect(@user).not_to be_valid
  end
end
