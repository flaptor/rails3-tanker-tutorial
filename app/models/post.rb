class Post < ActiveRecord::Base
  has_many :comments
  include Tanker
  tankit 'rails_3_tanker_demo' do
    indexes :title
    indexes :timestamp do
      Time.new.to_i
    end
  end
  after_save :update_tank_indexes
  after_destroy :delete_tank_indexes
end
