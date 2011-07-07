class Comment < ActiveRecord::Base
  belongs_to :post

  def postname
    self.post.title
  end
end
