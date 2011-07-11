class Post < ActiveRecord::Base
  
  include Tanker                             # include Tanker's module
  tankit 'rails_3_tanker_tutorial' do        # set the name of the index that tanker will use for this class
    indexes :name                            # index the field 'name'
    indexes :title                           # index the field 'title'
    indexes :content                         # index the field 'content'
    indexes :timestamp do                    # index the field 'timestamp' with the creation timestamp
      Time.new.to_i
    end

    variables do
      {
        0 => votes.nil? ? 0 : votes
      }
    end

    functions do
      {
        1 => "d[0]",                         # sort desc by votes
        2 => "age"                           # sort desc by votes
      }
    end

  end

  after_save :update_tank_indexes            # add hooks to save, update 
  after_destroy :delete_tank_indexes         # and delete methods
end
