class BlogPostsController < ApplicationController
  before_action :blog_line, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @blog_post= user_signed_in? ? BlogPost.sorted : BlogPost.published.sorted
    @pagy, @blog_post = pagy(@blog_post)
  rescue Pagy::OverflowError
    redirect_to root_path(page: 1)
  end

  def show
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def new
    @blog_post=BlogPost.new
  end

  def create
    @blog_post=BlogPost.new(set_blog)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(set_blog)
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
     @blog_post.destroy
      redirect_to root_path
  end

  private
  def set_blog
    params.require(:blog_post).permit(:title,:content,:cover_image,:published_at)
  end

  def blog_line
    if user_signed_in?
      @blog_post=  BlogPost.find(params[:id])
    else
      @blog_post= BlogPost.published.find(params[:id])
    end
  end
end
