class Comment < ActiveRecord::Base
  belongs_to :post

  include Tanker
  tankit 'rails_3_tanker_demo' do  
    indexes :commenter
    indexes :postname
  end

  def postname
    self.post.title
  end

  after_save :update_tank_indexes
  after_destroy :delete_tank_indexes

end
