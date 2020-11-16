# frozen_string_literal: true

class Api::V1::IdeasController < ApplicationController
  def create
    category = Category.find_or_create_by(name: params[:idea][:category_name])
    category.ideas.create!(body: params[:idea][:body])
    render status: :created, json: {}
  end

  private

  def idea_params
    params.require(:idea).permit(:category_name, :body)
  end
end
