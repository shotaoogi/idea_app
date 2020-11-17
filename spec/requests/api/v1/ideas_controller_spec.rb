# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::IdeasController, type: :request do
  describe 'GET /api/v1/idea' do
    let(:category) { create(:category, name: 'category_name') }
    let(:category_name) { 'category_name' }

    before do
      create(:idea, id: 1234, body: 'body_1234', category: category)
      create(:idea, id: 5678, body: 'body_5678')
    end

    it do
      aggregate_failures do
        get api_v1_ideas_path(category_name: category_name)
        expect(response).to have_http_status(:ok)
        expect(response_json[0][:id]).to eq(1234)
        expect(response_json[0][:category]).to eq('category_name')
        expect(response_json[0][:body]).to eq('body_1234')
        expect(response_json).not_to include(5678)
      end
    end

    context 'category_name の指定がない場合' do
      it do
        aggregate_failures do
          get api_v1_ideas_path
          expect(response).to have_http_status(:ok)
          expect(response_json[0][:id]).to eq(1234)
          expect(response_json[0][:category]).to eq('category_name')
          expect(response_json[0][:body]).to eq('body_1234')
          expect(response_json[1][:id]).to eq(5678)
          expect(response_json[1][:body]).to eq('body_5678')
        end
      end
    end

    context '存在しない category_name を指定した場合' do
      it do
        aggregate_failures do
          get api_v1_ideas_path(category_name: 'invalid_name')
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

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
