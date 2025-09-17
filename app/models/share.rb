# app/models/share.rb

class Share < ApplicationRecord
  # --- 既存のアソシエーション（関連付け） ---
  belongs_to :user
  has_many :comments, dependent: :destroy

  # --- Active Storageの設定 ---
  has_one_attached :image

  # --- ここからがバリデーションの追加部分 ---

  # `about`（テキスト）と `image`（画像）のどちらか一方は必須、というカスタムバリデーション
  validate :at_least_one_field_present

  private

  # カスタムバリデーションの具体的な処理を定義するメソッド
  def at_least_one_field_present
    # `about` テキストが空（nilまたは空文字列）で、かつ、`image` も添付されていない場合にエラーとする
    if about.blank? && !image.attached?
      # エラーメッセージを `errors` オブジェクトに追加する
      # `:base` を指定することで、特定のフィールドに関連しない、モデル全体のエラーとして扱われる
      errors.add(:base, "画像とコメントのどちらか一方は入力してください。")
    end
  end

end
