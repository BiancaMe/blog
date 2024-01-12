require 'rails_helper'

RSpec.describe User, type: :model do
  subject = User.new(name: 'Bianca', photo: 'photo.com.uy', bio: 'developer from Uruguay')
  subject.save
  before { subject.save }

  it 'Name must not be blank.' do
    expect(subject).to be_valid
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'PostsCounter must be an integer greater than or equal to zero.' do
    subject.name = 'Bianca'
    expect(subject).to be_valid
    subject.posts_counter = -1
    expect(subject).to_not be_valid
    subject.posts_counter = nil
    expect(subject).to_not be_valid
    subject.posts_counter = 5
    expect(subject).to be_valid
  end

  it 'Recents posts' do
    subject.posts_counter = 0
    Post.create(author: subject, title: 'First Post', text: 'Welcome to my new post', created_at: 3.day.ago)
    post2 = Post.create(author: subject, title: 'Second Post', text: 'Welcome to my new post', created_at: 2.day.ago)
    post3 = Post.create(author: subject, title: 'Three Post', text: 'Welcome to my new post', created_at: 1.day.ago)
    post4 = Post.create(author: subject, title: 'Four Post', text: 'Welcome to my new post')
    expect(subject.recents).to eq([post4, post3, post2])
  end
end
