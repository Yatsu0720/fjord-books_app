# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :followers_relations,
           class_name: 'FollowRelation',
           foreign_key: 'follower_id',
           dependent: :destroy,
           inverse_of: :follower

  has_many :followed_relations,
           class_name: 'FollowRelation',
           foreign_key: 'followed_id',
           dependent: :destroy,
           inverse_of: :followed

  has_many :followings, through: :followers_relations, source: :followed
  has_many :followers, through: :followed_relations, source: :follower

  def follow(other_user)
    followings << other_user
  end

  def unfollow(other_user)
    followers_relations.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
