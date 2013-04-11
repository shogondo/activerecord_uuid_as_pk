class Account < ActiveRecord::Base

  attr_accessible :id, :name

  uuid_as_primary_key

end
