require 'rails_helper'

describe 'User', type: :module do
  let(:user){ FactoryBot.build(:user) }
  subject{ user }

  it 'ユーザー名、メールアドレス、パスワードがあれば有効な状態であること' do
    is_expected.to be_valid
  end

  it 'ユーザー名がなければ無効な状態であること' do
    user.name = ''
    is_expected.not_to be_valid
  end

  it 'メールアドレスがなければ無効な状態であること' do
    user.email = ''
    is_expected.not_to be_valid
  end

  it 'パスワードがなければ無効な状態であること' do
    user.password_digest = ''
    is_expected.not_to be_valid
  end

  it "パスワードとパスワード(確認)が不一致なら無効な状態であること" do
    user.password_confirmation = "mismatch"
    is_expected.not_to be_valid
  end

  describe "ユーザー認証" do
    before { user.save }
    let(:found_user) { User.find_by(email: user.email) }
  
    context "有効なパスワードの場合" do
      it { is_expected.to eq found_user.authenticate(user.password) }
    end
  
    context "無効なパスワードの場合" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
  
      it { is_expected.not_to eq user_for_invalid_password }
      it { expect(user_for_invalid_password).to be_falsey }
    end
  end

  it 'ユーザー名が12文字より長ければ無効な状態であること' do
    user.name = 'a' * 13
    is_expected.not_to be_valid
  end

  it 'メールアドレスが255文字より長ければ無効な状態であること' do
    user.email = 'a' * 244 + '@example.com'
    is_expected.not_to be_valid
  end

  it "不正な形式のメールアドレスであれば無効な状態であること" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                   foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
      user.email = invalid_address
      is_expected.not_to be_valid
    end
  end

  it "正しい形式のメールアドレスであれば有効な状態であること" do
    addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    addresses.each do |valid_address|
      user.email = valid_address
      is_expected.to be_valid
    end
  end

  it '重複したメールアドレスなら無効な状態であること' do
    user_with_same_email = user.dup
    user_with_same_email.save
    is_expected.not_to be_valid
  end

  it 'パスワードが空文字なら無効な状態であること' do
    user.password = user.password_confirmation = ' ' * 8
    is_expected.not_to be_valid
  end
    
  it 'パスワードが12文字より大きいなら無効な状態であること' do
    user.password = user.password_confirmation = 'a' * 13
    is_expected.not_to be_valid
  end

  it 'パスワードが8文字未満なら無効な状態であること' do
    user.password = user.password_confirmation = 'a' * 5
    is_expected.not_to be_valid
  end

  describe 'follow' do
    before do
      @test_user = User.create(
        name:'test_user',
        email:'test@email.com',
        password:'password'
      )
    end
    it 'ユーザーをフォローすること' do
      user.follow(@test_user)
      expect(user.following[0].name).to eq 'test_user'
    end

    it '現在のユーザーがフォローしていたらtrueを返すこと' do
      user.follow(@test_user)
      expect(user.following?(@test_user)).to eq true
    end
  end
end
