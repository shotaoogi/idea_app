# frozen_string_literal: true

class ApplicationController < ActionController::Base
  class UnprocessableEntity < StandardError; end
  class RecordInvalid < StandardError; end
  class RecordNotSaved < StandardError; end

  rescue_from UnprocessableEntity, with: :render422
  rescue_from ActiveRecord::RecordInvalid, with: :render422
  rescue_from ActiveRecord::RecordNotSaved, with: :render422

  def render422(_exception)
    render status: :unprocessable_entity, json: {}
  end
end
