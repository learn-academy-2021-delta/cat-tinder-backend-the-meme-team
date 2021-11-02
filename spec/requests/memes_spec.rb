require 'rails_helper'

RSpec.describe "Memes", type: :request do
  describe "GET /index" do
    it "gets a list of memes" do
      Meme.create name: 'Shaun', url: 'google.com', description: 'Walks in the park'

      get '/memes'

      meme = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(meme.length).to eq 1
    end
  end

  describe "POST /create" do
    it 'creates a meme' do

      meme_params = {
        meme: {
          name: 'Kevin',
          url: 'google.com',
          description: 'Kevin meme'
        }
      }

      post '/memes', params: meme_params
      expect(response).to have_http_status(200)

      meme = Meme.first 
      expect(meme.name).to eq 'Kevin'
      expect(meme.url).to eq 'google.com'
      expect(meme.description).to eq 'Kevin meme'

    end
  end

  describe "PATCH /update" do
    it 'updates a meme' do
      meme_params = {
        meme: {
          name: 'Kelly',
          url: 'google.com',
          description: 'Kelly meme'
        }
      }

      post '/memes', params: meme_params
      meme = Meme.first

      updated_meme_params = {
        meme: {
          name: 'Kelly',
          url: 'www.google.com',
          description: 'Kelly meme'
        }
      }
      patch "/memes/#{meme.id}", params: updated_meme_params 
      meme = Meme.first
      expect(response).to have_http_status(200)
      expect(meme.url).to eq 'www.google.com'
    end
  end

  describe "DELETE /destroy" do
    it 'deletes a meme' do
      meme_params = {
        meme: {
          name: 'Rob',
          url: 'google.com',
          description: 'Rob Meme'
        }
      }
      post '/memes', params: meme_params
      meme = Meme.first
      delete "/memes/#{meme.id}"
      expect(response).to have_http_status(200)
      memes = Meme.all
      expect(memes).to be_empty
    end
  end




end