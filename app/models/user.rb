class User < ActiveRecord::Base
    has_secure_password #allows us to use authenticate which takes pass as plain string and allows you to check against Bcrypts hash
    validates :username, presence: true
    validates :username,  uniqueness: true
    has_many :logs
end 