class AvatarUploader < CarrierWave::Uploader::Base

  # 画像リサイズ用にRMagickをinclude
  include CarrierWave::RMagick

  # iPhoneから画像投稿した際に、画像の向きがおかしい場合があるので、
  # Rmagickのauto_orientメソッドで向きを正す。
  process :fix_rotate
  def fix_rotate
    manipulate! do |img|
      img = img.auto_orient
      img = yield(img) if block_given?
      img
    end
  end

  # Choose what kind of storage to use for this uploader:
  # ストレージの設定(S3アップロード用にfogを指定)
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # アップロード先のディレクトリの設定
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # 許可するファイル拡張子の設定
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # ファイル名の設定(ランダムな16進数文字列をファイル名の先頭に付与)
  def filename
     "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end

  # Create different versions of your uploaded files:
  # リサイズの設定
  version :thumb do
      process resize_to_fit: [350, 350]
  end
end