class BlogPosts::CoverImagesController < ApplicationController
include ActionView::RecordIdentifier
  before_action :authenticate_user!

  def destroy
    @blog_post=BlogPost.find(params[:blog_post_id])
    @blog_post.cover_image.purge_later
    respond_to do |format|
    format.html {redirect_to edit_blog_post_path(@blog_post)}
    format.turbo_stream {render turbo_stream: turbo_stream.remove(dom_id(@blog_post, :cover_image))}
    end
  end
end
