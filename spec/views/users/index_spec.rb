require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Users', type: :system do
  before do
    @user1 = User.create(name: 'Melanie', photo: '', bio: 'Hello my name is Melanie')
    @user2 = User.create(name: 'Bianca', photo: '', bio: 'Hello my name is Bianca')
  end

  scenario 'Index, check if the info of user1 and user2 appears' do
    visit users_path
    expect(page).to have_content(@user1.name)
    expect(page).to have_css('img')
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")

    expect(page).to have_content(@user2.name)
    expect(page).to have_css('img')
    expect(page).to have_content("Number of posts: #{@user2.posts_counter}")
  end

  scenario 'Redirects to show' do
    visit users_path
    click_link(@user1.name)
    expect(page).to have_current_path(user_path(@user1.id))
    expect(page).to have_content(@user1.name)
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
  end
end
