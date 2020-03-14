class RelationshipsController < ApplicationController
  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    redirect_to user_path(current_user)
  end

  #def create
    #@user = User.find(params[:relationship][:following_id])
    #current_user.follow!(@user)
    # ここから
    #@user.create_notification_follow!(current_user)
    # ここまで
    #respond_to do |format|
      #format.html { redirect_to @user }
      #format.js
    #end
  #end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_to root_path
  end
end
