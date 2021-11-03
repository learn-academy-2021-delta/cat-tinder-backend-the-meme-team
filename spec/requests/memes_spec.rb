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
          description: 'This is a Rob Meme'
        }
      }
      post '/memes', params: meme_params
      meme = Meme.first
      delete "/memes/#{meme.id}"
      expect(response).to have_http_status(200)
      meme = Meme.first
      expect(meme).to eq nil
    end
  end

  describe 'meme validation error codes' do
    it 'does not create a meme without a name' do
      meme_params = {
        meme: {
          url: 'google.com',
          description: 'Kevin Meme'
        }
      }
      post '/memes', params: meme_params
      expect(response).to have_http_status(422)
      meme = JSON.parse(response.body)
      expect(meme['name']).to include "can't be blank"
    end
    it 'does not create a meme without a url' do
      meme_params = {
        meme: {
          name: 'Kevin',
          description: 'Kevin Meme'
        }
      }
      post '/memes', params: meme_params
      expect(response).to have_http_status(422)
      meme = JSON.parse(response.body)
      expect(meme['url']).to include "can't be blank"
    end
    it 'does not create a meme without a description' do
      meme_params = {
        meme: {
          name: 'Kevin',
          url: 'google.com'
        }
      }
      post '/memes', params: meme_params
      expect(response).to have_http_status(422)
      meme = JSON.parse(response.body)
      expect(meme['description']).to include "can't be blank"
    end
  end

  describe "cannot update a meme without valid attributes" do
    it 'cannot update a meme without a name' do
      meme_params = {
        meme: {
          name: 'Rob',
          url: 'google.com',
          description: 'Roberts meme'
        }
      }
      post '/memes', params: meme_params
      meme = Meme.first
      # p Meme.all
      meme_params = {
        meme: {
          name: '',
          url: 'google.com',
          description: 'Roberts meme'
        }
      }
      
      patch "/memes/#{meme.id}", params: meme_params
      meme = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(meme['name']).to include "can't be blank"
    end

    it 'cannot update a meme without a url' do
      meme_params = {
        meme: {
          name: 'Rob',
          url: 'google.com',
          description: 'Roberts meme'
        }
      }
      post '/memes', params: meme_params
      meme = Meme.first
      meme_params = {
        meme: {
          name: 'Rob',
          url: '',
          description: 'Roberts meme'
        }
      }
      patch "/memes/#{meme.id}", params: meme_params
      meme = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(meme['url']).to include "can't be blank"
    end

    it 'cannot update a meme without an description' do
      meme_params = {
        meme: {
          name: 'Rob',
          url: 'google.com',
          description: 'Roberts meme'
        }
      }
      post '/memes', params: meme_params
      meme = Meme.first
      meme_params = {
        meme: {
          name: 'Rob',
          url: 'google.com',
          description: '',
        }
      }
      patch "/memes/#{meme.id}", params: meme_params
      meme = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(meme['description']).to include "can't be blank"
    end
    it 'cannot update a meme without a description that is at least 10 characters' do
      meme_params = {
        meme: {
          name: 'Rob',
          url: 'google.com',
          description: 'ricky bobby meme'
        }
      }
      post '/memes', params: meme_params
      meme = Meme.first
      meme_params = {
        meme: {
          name: 'Rob',
          url: 'google.com',
          description: 'meme'
        }
      }
      patch "/memes/#{meme.id}", params: meme_params
      meme = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(meme['description']).to include 'is too short (minimum is 10 characters)'
    end
  end





end