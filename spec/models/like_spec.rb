require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.new(name: 'Bianca', photo: 'photo.com.uy', bio: 'developer from Uruguay')
  user.save
  post = Post.new(author: user, title: 'First Post', text: 'Welcome to my first post')
  like = Like.new(post:, user:)
  like.save

  before { post.save }

  it 'Increment Like counter.' do
    expect(post.likes_counter).to eq(1)
  end

  it 'Decrement Like counter.' do
    like.destroy
    expect(post.likes_counter).to eq(0)
  end
end
