
require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  before (:each) do
      @mock_movie_attributes = {:title => 'Dunkirk', :release_date => '2017-07-13', :rating => 'PG', :director => 'Christopher Nolan'}
      @mock_movie = FactoryGirl.create(:movie)
  end
    
  describe "GET #show" do
    it "should pass the requested movie to @movie" do
      get :show, id: @mock_movie
      expect(assigns(:movie).title).to include("Inception")
    end
    it "should render the show template" do
      get :show, id: @mock_movie
      expect(response).to render_template(:show)
    end
  end
    
  describe 'GET index' do
    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end
    it 'should assign instance variable for title header' do
      get :index, {sort: 'title'}
      expect(assigns(:title_header)).to eql('hilite')
    end
    it 'should assign instance variable for release_date header' do
      get :index, { sort: 'release_date'}
      expect(assigns(:date_header)).to eql('hilite')
    end
  end
    
  describe "POST #create" do
      it "should create a new movie in the record" do
          expect {
          post :create, movie: @mock_movie_attributes
          }.to change(Movie,:count).by(1)
      end
      it "should assign the saved movie to @movie" do
          post :create, movie: @mock_movie_attributes
          expect(assigns(:movie).title).to include("Dunkirk")
      end
      it "should redirect to the homepage" do
          post :create, movie: @mock_movie_attributes
          expect(response).to redirect_to(:action => 'index')
      end
  end
    
  describe "PUT #update" do
    it "should locate the requested movie" do
      put :update, id: @mock_movie, movie: @mock_movie_attributes
      expect(assigns(:movie)).to eq(@mock_movie)
    end
    it "should change the requested movies attributes" do
      put :update, id: @mock_movie, movie: @mock_movie_attributes
      @mock_movie.reload
      expect(@mock_movie.title).to eq("Dunkirk")
      expect(@mock_movie.rating).to eq("PG")
    end
    it "should redirect to the updated movie" do
      put :update, id: @mock_movie, movie: @mock_movie_attributes
      expect(response).to redirect_to @contact
    end
  end
  
  describe "GET #same_director" do
    it "should show movies with the same director" do
      get :same_director, id: @mock_movie
      expect(assigns(:movie).title).to include("Inception")
    end        
  end
  
  describe "DELETE #destroy" do
    it "should delete the movie" do
      expect{
        delete :destroy, id: @mock_movie
      }.to change(Movie,:count).by(-1)
    end
    it "should redirect to the main page " do
      delete :destroy, id: @mock_movie
      expect(response).to redirect_to(:action => 'index') 
    end
  end
    
end
