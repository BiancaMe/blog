require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Posts', type: :system do
  let!(:user) { User.create(name: 'Melanie', photo: '', bio: 'Hello my name is Melanie') }
  let!(:post) { Post.create(author_id: user.id, title: 'Coding in Java', text: 'Text1') }
  let!(:comments) { create_list(:comment, 6, post:) }
  let!(:comments) do
    Comment.create(post_id: post.id, user_id: user.id, text: 'Hello Melanie, how are you today?')
    Comment.create(post_id: post.id, user_id: user.id, text: 'Im well')
    Comment.create(post_id: post.id, user_id: user.id, text: 'studing')
  end

  scenario 'Index' do
    visit user_posts_path(user)
    expect(page).to have_content(user.name)
    expect(page).to have_css('.user-img-container')
    expect(page).to have_content('Number of posts: 1')

    expect(page).to have_content(post.title)
    expect(page).to have_content('Text1')
    expect(page).to have_content('Comments: 3')
    expect(page).to have_content('Likes: 0')
  end

  scenario 'Redirects to show' do
    visit user_posts_path(user)
    click_link(post.title)
    expect(page).to have_current_path(user_post_path(user, post))
  end
end
