class PostsController < ApplicationController

  before_action :find_post, except: [:new, :create, :index]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def new
      @post = Post.new
  end

  def create
      @post = Post.new post_params
      @post.user = current_user
      if @post.save
          flash[:notice] = "New Post Created"
          redirect_to post_path(@post)
      else  
          render :new, status: 303
      end
  end

  def show
     @comments = @post.comments.order(created_at: :desc)
     @comment = Comment.new
  end

  def index
      @posts = Post.order(created_at: :desc)
  end

  def edit
  end

  def update
      @post.update post_params
      if @post.save
          flash[:notice] = "Post Updated"
          redirect_to post_path(@post)
      else  
          render :edit, status: 303
      end

  end

  def destroy 
      @post.destroy
      flash[:notice] = "Post Deleted"
      redirect_to posts_path
  end

  private

  def post_params
      params.require(:post).permit!
  end

  def find_post
      @post = Post.find params[:id]
  end

  def authorize_user!
      redirect_to post_path(@post), notice: "Not Authorized" unless can?(:crud, @post)
  end
end