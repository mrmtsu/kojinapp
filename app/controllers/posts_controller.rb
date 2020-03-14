class PostsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    # @category = Category.find(1)
    # @parent = Category.find_by(ancestry: nil)
    #↓一文追加
    # @topics = Post.all
    # @parents = Category.where(ancestry: nil)
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(18)
    @post = Post.new
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end
    #ログインしている場合（フォローしている人の投稿のみ表示）
    if user_signed_in?
      @user = current_user
      @users = @user.followings.order("created_at DESC").page(params[:page]).per(20)
    else
      
    end
  end

  def new
    #↓一文追加
    @topic = Post.new
    # @parents = Category.all.order("id ASC").limit(2)
    @post = Post.new
    @posts = Post.includes(:user)
  end

  def create
    #@post = Post.new(text:params[:text],image:params[:image],user_id:params[:user_id])
    #@post.save
    #redirect_to("/")
    #tag_list = params[:tag_name].split(",")
    #if @post.save
      #@post.save_posts(tag_list)
    #end

    #@topic = current_user.posts.new(post_params)
    #if @topic.save
      #redirect_to root_path
    #else
      #render 'post/new'
    #end

    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  def edit
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to root_path
  end

  def show
    @topic = Post.find(params[:id])
    #@parents = Category.all.order("id ASC").limit(2)
    #@comment = Comment.new
    @comments = @post.comments.includes(:user)
    @posts = Post.includes(:user)
    #@post = Post.find(params[:id])
    #@favorite = Favorite.new
    #@bookmark = Bookmark.new
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @comment    = Comment.new
    
    @post = Post.find(params[:id])
    @new_history = @post.browsing_histories.new
    @new_history.user_id = current_user.id
    if current_user.browsing_histories.exists?(post_id: "#{params[:id]}")
      old_history = current_user.browsing_histories.find_by(post_id: "#{params[:id]}")
      old_history.destroy
    end
    
    @new_history.save
    histories_stock_limit = 10
    histories = current_user.browsing_histories.all
    if histories.count > histories_stock_limit
      histories[0].destroy
    end
    @all_history = Post.find(BrowsingHistory.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end

  def search
    @posts = Post.search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end
  end


  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    
    @posts = @tag.posts.build
    @post  = @tag.posts.page(params[:page])
    @comment    = Comment.new
    @comments   = @posts.comments
  end
  
  def following_posts
    @user = current_user
    @users = @user.followings.order("created_at DESC").page(params[:page]).per(20)
  end
  

  private
  def post_params
    params.require(:post).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @post = Post.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end


end
