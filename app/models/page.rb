class Page < ApplicationRecord

  ## Relationship
  has_many :html_elements, dependent: :destroy

  ## Validations
  validates :url, presence: true
end
