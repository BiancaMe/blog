require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'User Show', type: :feature do
  before do
    @user = User.create(name: 'Melanie', photo: '', bio: 'Hello my name is Melanie')
    @post1 = Post.create(author_id: @user.id, title: 'One More', text: 'text4')
    @post2 = Post.create(author_id: @user.id, title: 'Coding in Java', text: 'Text1')
    @post3 = Post.create(author_id: @user.id, title: 'Country live', text: 'Text2')
    @post4 = Post.create(author_id: @user.id, title: 'How are you', text: 'text3')


    visit user_path(@user)
  end

  scenario 'Profile' do
    expect(page).to have_css('.user-item')
    expect(page).to have_content(@user.name)
    expect(page).to have_css('.user-img-container')
    expect(page).to have_content('Number of posts: 4')
    expect(page).to have_content(@user.bio)

    expect(page).to have_content('Coding in Java')
    expect(page).to have_content('Country live')
    expect(page).to have_content('How are you')
    expect(page).not_to have_content('One More')

    expect(page).to have_link('See all posts', href: user_posts_path(@user))
  end

  scenario 'When I click a users post, it redirects me to that posts show page' do
    click_link('Coding in Java')
    expect(page).to have_current_path(user_post_path(@user, @post2.id))
  end

  scenario 'Cliking see all posts go to user s post s index page' do
    click_link('See all posts')
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
