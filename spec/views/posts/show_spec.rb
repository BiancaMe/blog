require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'Post Show', type: :feature do
  let!(:user) { User.create(name: 'Melanie', photo: '', bio: 'Hello my name is Melanie') }
  let!(:post) { Post.create(author_id: user.id, title: 'Coding in Java', text: 'Text1') }
  let!(:comment1) { Comment.create(post_id: post.id, user_id: user.id, text: 'Hello Melanie, how are you today?') }
  let!(:comment2) { Comment.create(post_id: post.id, user_id: user.id, text: 'Im well') }

  scenario 'Show' do
    visit user_posts_path(user, post)
    expect(page).to have_content(post.title)
    expect(page).to have_content(user.name)
    expect(page).to have_content('Text1')
    expect(page).to have_content('Comments: 2')
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content('Coding in Java')

    expect(page).to have_content(comment1.text)
    expect(page).to have_content(comment2.text)
  end
end
