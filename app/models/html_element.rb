class HtmlElement < ApplicationRecord
  # Define Grabbed HTML tags
  enum name: [ :h1, :h2, :h3, :a ], _prefix: true

  CATEGORIES = {
    h1: :header_tags,
    h2: :header_tags,
    h3: :header_tags,
    a: :links
  }

  ## Relationship
  belongs_to :page

  ## Validations
  validates :name, presence: true
  validates :value, presence: true
end
