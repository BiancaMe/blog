class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  after_create :increment_counter
  after_destroy :decrement_counter

  private

  def increment_counter
    post.increment!(:comments_counter)
  end

  def decrement_counter
    post.decrement!(:comments_counter)
  end
end
