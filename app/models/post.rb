class Post < ActiveRecord::Base
  belongs_to :topic, :inverse_of => :posts
  belongs_to :user, :inverse_of => :posts

  validates_presence_of :topic, :user
  validates_presence_of :content

  after_save :update_topic_posts_count

  private
    def update_topic_posts_count
      self.topic.increment(:posts_count)
    end
end
