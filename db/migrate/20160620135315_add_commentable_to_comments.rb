class AddCommentableToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :commentable, polymorphic: true, index: true
    remove_column :comments, :post_id
  end
end
