class Posting < ActiveRecord::Base

  # 'type' is a reserved attribute, but you can change it
  # - we have column named type so that is why we must change it.
	self.inheritance_column = :_type_disabled
end

