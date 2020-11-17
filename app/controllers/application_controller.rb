# frozen_string_literal: true

class ApplicationController < ActionController::Base
  class UnprocessableEntity < StandardError; end
  class RecordInvalid < StandardError; end
  class RecordNotSaved < StandardError; end
  class Forbidden < StandardError; end

  rescue_from UnprocessableEntity, with: :render422
  rescue_from ActiveRecord::RecordInvalid, with: :render422
  rescue_from ActiveRecord::RecordNotSaved, with: :render422
  rescue_from ActiveRecord::RecordNotFound, with: :render404

  def render422(_exception)
    render status: :unprocessable_entity, json: {}
  end

  def render404(_exception)
    render status: :not_found, json: {}
  end
end
