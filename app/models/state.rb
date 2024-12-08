class State < ApplicationRecord
  validates :name, uniqueness: true

  def to_s
    name
  end
end
