require 'spec_helper'

describe '記事アップロード', type: :system, js: true do

  subject { page }
  let(:img_folder_path) { "#{Rails.root}/spec/fixtures/image/" }
  let(:submit) { '投稿' }
  let(:title_error_message) { '#post_title_error_message' }
  let(:content_error_message) { '#post_content_error_message' }
  let(:images_preview_error_message) { '#images_preview_error_message' }

  context '無効な情報の場合' do
    before do
      @user = FactoryBot.create(:user)
      sing_in @user
      visit new_post_path
    end

    describe "失敗時にエラーメッセージが表示されること" do
      context '入力文字数が超過した場合' do
        before do
          fill_in 'title',    with: 'a' * 33
          fill_in 'content', with: 'a' * 301
        end
        it { is_expected.to have_content(title_error_message, '32文字以下で入力してください。') }
        it { is_expected.to have_content(content_error_message, '300文字以下で入力してください。') }
      end

      context '一度入力された内容が空になった場合' do
        before do
          fill_in 'title',    with: 'a'
          fill_in 'content', with: 'a'
          fill_in 'title',    with: ''
          fill_in 'content', with: ''
        end
        it { is_expected.to have_content(title_error_message, '1文字以上入力してください。') }
        it { is_expected.to have_content(content_error_message, '1文字以上入力してください。') }
      end

      # context '画像が6枚より多く選択された場合' do
      #   before do
      #     attach_file(
      #       'images_file_field',
      #       [
      #         img_folder_path + 'image_1.jpg',
      #         img_folder_path + 'image_2.jpg',
      #         img_folder_path + 'image_3.jpg',
      #         img_folder_path + 'image_4.jpg',
      #         img_folder_path + 'image_5.jpg',
      #         img_folder_path + 'image_6.jpg',
      #         img_folder_path + 'image_7.jpg'
      #       ],
      #       make_visible: true, multiple: true
      #     )
      #   end
      #   it { is_expected.to have_content(images_preview_error_message, '画像は６枚までです。') }
      # end
    end

    describe "投稿ボタンが非活性であること" do
      context '全ての情報が無効の場合' do
        it { is_expected.to have_button(submit, disabled: true) }
      end

      context '画像のみ無効の場合' do
        before do
          fill_in 'title',    with: 'a'
          fill_in 'content', with: 'a'
        end
        it { is_expected.to have_button(submit, disabled: true) }
      end

      # context 'titleのみ無効の場合' do
      #   before do
      #     attach_file(
      #       'images_file_field',
      #       img_folder_path + 'image_1.jpg',
      #       make_visible: true, multiple: true
      #     )
      #     fill_in 'content', with: 'a'
      #   end
      #   it { is_expected.to have_button(submit, disabled: true) }
      # end

      # context 'contentのみ無効の場合' do
      #   before do
      #     attach_file(
      #       'images_file_field',
      #       img_folder_path + 'image_1.jpg',
      #       make_visible: true, multiple: true
      #     )
      #     fill_in 'title', with: 'a'
      #   end
      #   it { is_expected.to have_button(submit, disabled: true) }
      # end
    end
  end

  # context '有効な情報の場合' do
  #   subject { page }
  #   let(:img_folder_path) { Rails.root + 'spec/fixtures/image/' }
  #   let(:submit) { '投稿' }

  #   before do
  #     @user = FactoryBot.create(:user)
  #     sing_in @user
  #     visit new_post_path
  #     find('.btn-file-select').click
  #     attach_file(
  #       'images_file_field',
  #       [
  #         img_folder_path + 'image_1.jpg',
  #         img_folder_path + 'image_2.jpg',
  #         img_folder_path + 'image_3.jpg',
  #         img_folder_path + 'image_4.jpg',
  #         img_folder_path + 'image_5.jpg',
  #         img_folder_path + 'image_6.jpg'
  #       ],
  #       make_visible: true, multiple: true
  #     )
  #     fill_in 'title', with: 'テスト投稿'
  #     fill_in 'content', with: 'テスト用の投稿です。'
  #   end

  #   it '投稿ボタンが活性状態であること' do
  #     is_expected.to have_button(submit, disabled: false)
  #   end

  #   it 'マイページに遷移すること' do
  #     click_button submit
  #     is_expected.to have_title(@user.name)
  #   end

  #   it '投稿された記事が存在すること' do
  #     click_button submit
  #     is_expected.to have_content('テスト投稿')
  #   end
  # end
end