# frozen_string_literal: true

class FollowRelationsController < ApplicationController
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end

  def destroy
    user = FollowRelation.find_by(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
end