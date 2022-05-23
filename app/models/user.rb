class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: %i[google_oauth2]
          has_many :posts, dependent: :destroy #追記 ユーザーが削除されたら、ツイートも削除されるようになります。すでに書いてある場合は追記しなくて大丈夫です。
          validates :name, presence: true #追記
          validates :profile, length: { maximum: 200 } #追記
          has_many :likes, dependent: :destroy
          has_many :liked_posts, through: :likes, source: :post
          has_many :comments, dependent: :destroy
          has_many :messages, dependent: :destroy
          has_many :entries, dependent: :destroy

          def already_liked?(post)
            self.likes.exists?(post_id: post.id)
          end

          def self.from_omniauth(auth)
            where(provider: auth.provider, uid: auth.uid).first_or_create do |user|        
              user.name = auth.info.name
              user.profile = auth.info.profile
              user.email = auth.info.email
              user.password = Devise.friendly_token[0,20]
            end
          end
end
