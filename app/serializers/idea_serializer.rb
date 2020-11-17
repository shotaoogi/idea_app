# frozen_string_literal: true

class IdeaSerializer < ActiveModel::Serializer
  attribute :id
  attribute :category
  attribute :body

  def category
    object.category.name
  end
end
