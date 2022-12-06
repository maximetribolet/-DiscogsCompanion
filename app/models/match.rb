class Match < ApplicationRecord
  belongs_to :alert
  belongs_to :product
  # validates :link_to_product, presence: true

end
