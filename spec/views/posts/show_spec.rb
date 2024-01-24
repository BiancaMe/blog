require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'Post Show', type: :feature do
  let!(:user) { User.create(name: 'Melanie', photo: '', bio: 'Hello my name is Melanie') }
  let!(:user2) { User.create(name: 'Pedro', photo: '', bio: 'Hello my name is Pedro') }
  let!(:post) { Post.create(author_id: user.id, title: 'Coding in Java', text: 'Text1') }
  let!(:comment1) { Comment.create(post_id: post.id, user_id: user2.id, text: 'Hello Melanie, how are you today?') }

  scenario 'Show' do
    visit user_posts_path(user, post)
    expect(page).to have_content(post.title)
    expect(page).to have_content(user.name)
    expect(page).to have_content('Text1')
    expect(page).to have_content('Comments: 1')
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content('Coding in Java')

    expect(page).to have_content('Pedro')
    expect(page).to have_content('Hello Melanie, how are you today?')
  end
end
