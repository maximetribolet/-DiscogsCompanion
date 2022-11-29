class Alert < ApplicationRecord
  belongs_to :product, dependent: :destroy
  belongs_to :user
end
