class MoveBodyToActionText < ActiveRecord::Migration[7.1]
  def change
    BlogPost.find_each do |blog_post|
      blog_post.update(content: blog_post.body)
    end
  end
end
