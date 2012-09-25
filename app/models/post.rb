class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  validates_numericality_of :user_id
  # validates_numericality_of :topic_id,
  validates_presence_of :content

  after_save :update_topic_posts_count

  private
    def update_topic_posts_count
      self.topic.increment(:posts_count)
    end
end
