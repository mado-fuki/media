require 'rails_helper'

describe 'Post', type: :module do
  let(:user){ FactoryBot.create(:user) } 
  let(:post) { user.posts.create(FactoryBot.attributes_for(:post)) }
  subject{ post }

  it 'user_id、タイトル、本文があれば有効な状態であること' do
    is_expected.to be_valid
  end

  it 'user_idがなければ無効な状態であること' do
    post.user_id = ''
    is_expected.not_to be_valid
  end

  it 'タイトルがなければ無効な状態であること' do
    post.title = ''
    is_expected.not_to be_valid
  end

  it '本文がなければ無効な状態であること' do
    post.content = ''
    is_expected.not_to be_valid
  end

  it 'タイトルが30文字以下でなければ無効な状態であること' do
    post.title = 'a' * 31
    is_expected.not_to be_valid
  end

  it '本文が300文字以下でなければ無効な状態であること' do
    post.content = 'a' * 301
    is_expected.not_to be_valid
  end
end