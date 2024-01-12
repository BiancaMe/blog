require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.new(name: 'Bianca', photo: 'photo.com.uy', bio: 'developer from Uruguay')
  user.save
  post = Post.new(author: user, title: 'First Post', text: 'Welcome to my first post')
  comment = Comment.new(text: 'Beatifull Post', post:, user:)
  comment.save

  before { post.save }

  it 'Increment Comments counter.' do
    expect(post.comments_counter).to eq(1)
  end

  it 'Decrement Comments counter.' do
    comment.destroy
    expect(post.comments_counter).to eq(0)
  end
end
