module UserImages
  class UserImage < ApplicationRecord
    belongs_to :user
  end
end