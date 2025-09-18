# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

config.active_storage.service = :cloudinary

  # Cloudinaryの認証情報を環境変数から直接読み込んで設定する
  # これにより、初期化のタイミング問題を回避する
  config.cloudinary.cloud_name = ENV['CLOUD_NAME']
  config.cloudinary.api_key = ENV['CLOUDINARY_API_KEY']
  config.cloudinary.api_secret = ENV['CLOUDINARY_API_SECRET']
  config.cloudinary.secure = true # HTTPSリンクを生成するために推奨