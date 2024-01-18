require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:all) do
    @user = User.new(name: 'Bianca')
    @user.save
  end

  describe 'GET /index' do
    before do
      get user_posts_path(@user)
    end

    it 'response status correct' do
      expect(response.status).to eq(200)
      expect(response).to be_successful
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'response body includes correct placeholders text' do
      expect(response.body).to include('Posts')
    end
  end

  describe 'GET /show' do
    before do
      @post = Post.create(author: @user, title: 'Test Post')
      get user_post_path(@user, @post)
    end

    it 'response status correct' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'response body includes correct placeholders text' do
      expect(response.body).to include('Post selected')
    end
  end
end
