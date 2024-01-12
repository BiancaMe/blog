class Like < ApplicationRecord
    belongs_to :post
    belongs_to :user
    after_create :increment_counter
    after_destroy :decrement_counter
  
    private
  
    def increment_counter
      post.increment!(:likes_counter)
    end
  
    def decrement_counter
      post.decrement!(:likes_counter)
    end
end