# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::IdeasController, type: :request do
  describe 'POST /api/v1/idea' do
    let(:category_name) { 'test_category_1' }
    let(:body) { 'test_body' }

    before do
      def params
        {
          idea: {
            category_name: category_name,
            body: body
          }
        }
      end
    end

    it do
      post api_v1_ideas_path, params: params
      expect(response).to have_http_status(:created)
    end

    context '作成済みの category_name を指定した場合' do
      let(:category_name) { 'test_category_2' }

      before { create(:category, name: 'test_category_2') }

      it do
        post api_v1_ideas_path, params: params
        expect(response).to have_http_status(:created)
      end
    end

    context 'category_name が空文字の場合' do
      let(:category_name) { '' }

      it do
        post api_v1_ideas_path, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'body が空文字の場合' do
      let(:body) { '' }

      it do
        post api_v1_ideas_path, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
