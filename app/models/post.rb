class Post < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments

  has_many :favorites, dependent: :destroy
  has_many :favorites_users, through: :favorites, source: :post
  
  
  has_many :post_categories
  has_many :categories, through: :post_categories
  #mount_uploader :image, ImageUploader

  has_many :bookmarks

  has_many :notifications, dependent: :destroy

  has_and_belongs_to_many :hashtags

  has_many :maps

  has_many :browsing_histories, dependent: :destroy
  
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  def self.search(search)
    return Post.all unless search
    Post.where('text LIKE(?)', "%#{search}%")
  end

  #DBへのコミット直前に実施する
  after_create do
    post = Post.find_by(id: self.id)
    hashtags  = self.text.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end

  before_update do 
    post = Post.find_by(id: self.id)
    post.hashtags.clear
    hashtags = self.text.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end



  def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end


  
  #scope :from_category, -> (category_id)  { where(id: article_ids = ArticleCategory.where(category_id: category_id).select(:article_id))}
  
  def save_posts(savepost_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags
  
      # Destroy old taggings:
      old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name:old_name)
      end
  
      # Create new taggings:
      new_tags.each do |new_name|
        post_tag = Tag.find_or_create_by(name:new_name)
        self.tags << post_tag
      end
    end
  end

end




# self.data = [
#   {id: 0, name: '--'},{id: 1, name: '北海道'}, {id: 2, name: '青森県'}, {id: 3, name: '岩手県'},
#     {id: 4, name: '宮城県'}, {id: 5, name: '秋田県'}, {id: 6, name: '山形県'},
#     {id: 7, name: '福島県'}, {id: 8, name: '茨城県'}, {id: 9, name: '栃木県'},
#     {id: 10, name: '群馬県'}, {id: 11, name: '埼玉県'}, {id: 12, name: '千葉県'},
#     {id: 13, name: '東京都'}, {id: 14, name: '神奈川県'}, {id: 15, name: '新潟県'},
#     {id: 16, name: '富山県'}, {id: 17, name: '石川県'}, {id: 18, name: '福井県'},
#     {id: 19, name: '山梨県'}, {id: 20, name: '長野県'}, {id: 21, name: '岐阜県'},
#     {id: 22, name: '静岡県'}, {id: 23, name: '愛知県'}, {id: 24, name: '三重県'},
#     {id: 25, name: '滋賀県'}, {id: 26, name: '京都府'}, {id: 27, name: '大阪府'},
#     {id: 28, name: '兵庫県'}, {id: 29, name: '奈良県'}, {id: 30, name: '和歌山県'},
#     {id: 31, name: '鳥取県'}, {id: 32, name: '島根県'}, {id: 33, name: '岡山県'},
#     {id: 34, name: '広島県'}, {id: 35, name: '山口県'}, {id: 36, name: '徳島県'},
#     {id: 37, name: '香川県'}, {id: 38, name: '愛媛県'}, {id: 39, name: '高知県'},
#     {id: 40, name: '福岡県'}, {id: 41, name: '佐賀県'}, {id: 42, name: '長崎県'},
#     {id: 43, name: '熊本県'}, {id: 44, name: '大分県'}, {id: 45, name: '宮崎県'},
#     {id: 46, name: '鹿児島県'}, {id: 47, name: '沖縄県'}
# ]