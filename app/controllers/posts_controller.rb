class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id].to_i)
    @posts = Post.where(author_id: @user.id)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_posts_path(current_user)
    else
      render 'new'
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
