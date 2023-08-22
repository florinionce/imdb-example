require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  describe 'GET /api/v1/movies' do
    subject { get '/api/v1/movies' }

    context 'when there are movies' do
      before do
        create_list(:movie, 5)

        subject
      end

      it 'returns all movies' do
        expect(response).to have_http_status(:success)
        expect(json['movies'].size).to eq(5)
        expect(json['movies']).to all(include('id', 'title', 'description', 'genre', 'year'))
        expect(json['meta']).to eq({ 'size' => 5 })
      end
    end

    context 'when there are no movies' do
      before { subject }

      it 'returns an empty array' do
        expect(response).to have_http_status(:success)
        expect(json['movies']).to eq([])
        expect(json['meta']).to eq({ 'size' => 0 })
      end
    end
  end

  describe 'POST /api/v1/movies' do
    subject { post '/api/v1/movies', params: { movie: movie_params } }
    context 'when the request is valid' do
      let(:movie_params) { attributes_for(:movie) }

      before { subject }

      it 'creates a movie' do
        expect(response).to have_http_status(:created)
        expect(json['movie']['title']).to eq(movie_params[:title])
      end
    end

    context 'when the request is invalid' do
      let(:movie_params) { attributes_for(:movie, title: nil) }

      before { subject }

      it 'returns a validation failure message' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['error']).to eq("Validation failed: Title can't be blank")
      end
    end
  end
end
