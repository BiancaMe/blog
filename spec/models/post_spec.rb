require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.new(name: 'Bianca', photo: 'photo.com.uy', bio: 'developer from Uruguay')
  user.save
  post = Post.new(author: user, title: 'First Post', text: 'Welcome to my first post')
  comment = Comment.new(text: 'Beatifull Post', post:, user:)
  comment.save
  like = Like.new(post:, user:)
  like.save

  before { post.save }

  it 'validate title blank' do
    expect(post).to be_valid
    post.title = nil
    expect(post).to_not be_valid
  end

  it 'validate title max 250' do
    post.title = 'title' * 5
    expect(post).to be_valid
    post.title = 'title' * 51
    expect(post).to_not be_valid
  end

  it 'Comments Counter must be an integer greater than or equal to zero.' do
    post.title = 'title'
    expect(post).to be_valid
    post.comments_counter = -1
    expect(post).to_not be_valid
    post.comments_counter = nil
    expect(post).to_not be_valid
    post.comments_counter = 5
    expect(post).to be_valid
  end

  it 'Likes Counter must be an integer greater than or equal to zero.' do
    expect(post).to be_valid
    post.likes_counter = -1
    expect(post).to_not be_valid
    post.likes_counter = nil
    expect(post).to_not be_valid
    post.likes_counter = 5
    expect(post).to be_valid
  end

  it 'Increment posts counter.' do
    Post.new(author: user, title: 'Second Post', text: 'Welcome to my first post')
    expect(user.posts_counter).to eq(1)
  end

  it 'Decrement posts counter.' do
    post2 = Post.new(author: user, title: 'Second Post', text: 'Welcome to my first post')
    expect(user.posts_counter).to eq(1)
    post2.destroy
    expect(user.posts_counter).to eq(0)
  end

  it 'Recent comments' do
    comment1 = Comment.create(post:, user:, text: 'Good', created_at: 1.day.ago)
    comment2 = Comment.create(post:, user:, text: 'Nice', created_at: 2.day.ago)
    comment3 = Comment.create(post:, user:, text: 'Awesome', created_at: 3.day.ago)
    comment4 = Comment.create(post:, user:, text: 'Like', created_at: 4.day.ago)
    Comment.create(post:, user:, text: 'Love it', created_at: 5.day.ago)

    expect(post.recents).to eq([comment, comment1, comment2, comment3, comment4])
  end
end
