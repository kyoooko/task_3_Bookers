class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: {minimum: 2, maximum: 20}
  validates :email, presence: true
  validates :introduction, length: {maximum: 50}
  
  attachment :profile_image 
  has_many :books, dependent: :destroy

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  # コメント機能
  has_many :book_comments, dependent: :destroy
  # いいね機能
  has_many :favorites, dependent: :destroy
  # フォロー機能
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

   # フォロー機能
  def follow(other_user)
    unless self == other_user # 自分以外の人であれば下記実行
      self.relationships.find_or_create_by(follow_id: other_user.id)#フォロー済みならRelation を返し、フォローしてなければフォロー関係を保存(create = new + save)する
    end
  end
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship #relationship が存在すれば(=フォロー済みなら) destroy 
  end
  def following?(other_user)
    self.followings.include?(other_user)
  end

  # 検索機能
  def self.search(search,word)
    if search == "forward_match"
      User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      User.where("name =?","#{word}")     
    elsif search == "partial_match"
      User.where("name LIKE?","%#{word}%")
    else
      User.all
    end
  end

end
