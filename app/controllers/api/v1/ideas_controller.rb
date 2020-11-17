# frozen_string_literal: true

class Api::V1::IdeasController < ApplicationController
  def index
    return render_json_ideas(Idea.all) if params[:category_name].blank?

    category = Category.find_by!(name: params[:category_name])

    render_json_ideas(category.ideas)
  end

  def create
    category = Category.find_or_create_by(name: params[:idea][:category_name])
    category.ideas.create!(body: params[:idea][:body])
    render status: :created, json: {}
  end

  private

  def idea_params
    params.require(:idea).permit(:category_name, :body)
  end

  def render_json_ideas(ideas)
    render status: :ok, json: ActiveModel::Serializer::CollectionSerializer.new(
      ideas,
      serializer: IdeaSerializer,
      key: 'data'
    )
  end
end
