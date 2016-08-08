class PageSerializer < ActiveModel::Serializer
  attributes :uid, :url

  has_many :html_elements do
    object.html_elements
  end

  def uid
    object.id
  end
end