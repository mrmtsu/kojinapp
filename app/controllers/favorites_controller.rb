class FavoritesController < ApplicationController

  #def create
    # こう記述することで、「current_userに関連したFavoriteクラスの新しいインスタンス」が作成可能。
    # つまり、favorite.user_id = current_user.idが済んだ状態で生成されている。
    # buildはnewと同じ意味で、アソシエーションしながらインスタンスをnewする時に形式的に使われる。
    #favorite = current_user.favorites.build(post_id: params[:post_id])
    #favorite.save
    #redirect_to posts_path
  #end

  #def destroy
    #favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    #favorite.destroy
    #redirect_to posts_path
  #end
  

  before_action :set_post

  def create
    @favorite = Favorite.create(user_id: current_user.id, post_id: params[:post_id])
    @favorites = Favorite.where(post_id: params[:post_id])
    @post.reload
  end

  def destroy
    favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
    favorite.destroy
    @favorites = Favorite.where(post_id: params[:post_id])
    @post.reload
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end


end
