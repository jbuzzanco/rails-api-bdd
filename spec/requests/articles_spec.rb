require 'rails_helper'

RSpec.describe 'Articles API' do
  def article_params
    # PARAMETERS for creating an article
    {
      title: 'One Weird Trick',
      content: 'You won\'t believe what happens next...'
    }
  end

  def articles
    # returns a list of all articles
    Article.all
  end

  def article
    # returns the first of all articles
    Article.first
  end

  before(:all) do
    # before each test create an article using the
    # article params above
    Article.create!(article_params)
  end

  after(:all) do
    # deletes the article after all tests have run
    Article.delete_all
  end

  # feature test
  # descrbing what happens when a get request is made to articles
  describe 'GET /articles' do
    # we explect the get request to return a list of all the articles
    it 'lists all articles' do
      # get is a function that takes a string , and makes a
      # get request to that address
      get '/articles'
      # expect to get a success (200) response
      expect(response).to be_success

      # sets the variable articles to the body of the
      # http response
      articles_response = JSON.parse(response.body)

      # expect the list of articles from server to be
      # same length as the list of articles we created
      expect(articles_response.length).to eq(articles.count)

      # check that the first article's title is equal to the article title
      # that we created
      expect(articles_response.first['title']).to eq(article['title'])
    end
  end

  describe 'GET /articles/:id' do
    it 'shows one article' do
      get "/articles/#{article.id}"

      expect(response).to be_success

      article_response = JSON.parse(response.body)

      expect(article_response['id']).not_to be_nil
      expect(article_response['title']).to eq(article_params[:title])
    end
  end

  describe 'DELETE /articles/:id' do
    it 'deletes an article' do
      delete "/articles/#{article.id}"

      expect(response).to be_success
      expect(response.body).to be_empty
    end
  end

  describe 'PATCH /articles/:id' do
    def article_diff
      { title: 'Two Stupid Tricks' }
    end

    it 'updates an article' do
      patch "/articles/#{article.id}", article: article_diff, format: :json

      expect(response).to be_success
      expect(response.body).to be_empty
      expect(article[:title]).to eq(article_diff[:title])
    end
  end

  describe 'POST /articles' do
    skip 'creates an article' do
    end
  end
end
