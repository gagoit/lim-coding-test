class HtmlElementSerializer < ActiveModel::Serializer
  attributes :uid, :name, :value

  def uid
    object.id
  end
end