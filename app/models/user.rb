class User < ApplicationRecord
    has_many :posts
    has_many :comments
    has_many :likes
    
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 250},
                                      format: { with: VALID_EMAIL_REGEX }
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}

    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
