module Qrs
  class Qrcode < ApplicationRecord
    belongs_to :user
  end
end