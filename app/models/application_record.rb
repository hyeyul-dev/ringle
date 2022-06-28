class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def searchable_type
    Music
  end
end
