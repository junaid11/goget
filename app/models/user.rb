class User < ApplicationRecord
    require 'securerandom'
    has_secure_password

    has_many :my_jobs, class_name: 'Job', foreign_key: :created_by, dependent: :destroy

    validates :name, :email, presence: true
    validates_uniqueness_of :email
end
