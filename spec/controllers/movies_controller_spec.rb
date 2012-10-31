require 'spec_helper'

describe MoviesController do

  describe "Find Movie With Same Director" do
    it "should call the model method that performs find similar movie" do
      Movie.stub(:find).and_return(mock('Movie', :title => "Test"))
      Movie.should_receive(:search).with("1")
      get :find_similar, :id => 1
    end
    it "should select the Search Result template for rendering" do
      Movie.stub(:find).and_return(mock('Movie', :title => "Test"))
      Movie.stub(:search).and_return(mock('Movie'))
      get :find_similar, :id => 1
      response.should render_template('find_similar')
    end
    it "should make the Search Result available to the template" do
      Movie.stub(:find).and_return(mock('Movie', :title => "Test"))
      fake_result = [mock('Movie'), mock('Movie')]
      Movie.stub(:search).and_return(fake_result)
      get :find_similar, :id => 1
      assigns(:movies).should == fake_result
    end
    it "should render the home page if no director" do
      Movie.stub(:find).and_return(mock('Movie', :title => "Test"))
      Movie.stub(:search).and_return(nil)
      get :find_similar, :id => 1
      response.should redirect_to movies_path
    end
  end

  describe "Creation, Edit, Update and Deletion" do
    it "should call the right create method" do
      Movie.stub(:create!).and_return(mock('Movie', :title => "Test"))
      Movie.should_receive(:create!).with('Movie')
      post :create, :movie => 'Movie'
      response.should redirect_to movies_path
    end
    it "should call the right edit method" do
      Movie.should_receive(:find).with("id")
      get :edit, :id => "id"
      response.should render_template("edit")
    end
    it "should call the right update method" do
      pilm = mock('Movie')
      pilm.stub(:title).and_return("Test")
      pilm.stub(:id).and_return(1)
      pilm.stub(:update_attributes!).and_return(pilm)
      Movie.stub(:find).and_return(pilm)
      Movie.should_receive(:find).with("id")
      put :update, :id => "id", :movie => pilm
      response.should redirect_to movie_path(pilm)
    end
    it "should call the right destroy method" do
      pilm = mock('Movie')
      pilm.stub(:id).and_return(1)
      pilm.stub(:destroy).and_return(nil)
      pilm.stub(:title).and_return("Test")
      Movie.stub(:find).and_return(pilm)
      Movie.should_receive(:find).with("id")
      delete :destroy, :id => "id"
    end
  end

  describe "show and index" do
    it "should show the home page" do
      Movie.should_receive(:find).with("id")
      get :show, :id => "id"
      response.should render_template('show')
    end
  end

  describe "home page" do
    it "should show all movie at the first time" do
      fake_result = [mock('Movie'), mock('Movie')]
      Movie.stub(:all_ratings).and_return(%w(G PG PG-13 NC-17 R))
      Movie.stub(:find_all_by_rating).and_return(fake_result)
      Movie.should_receive(:find_all_by_rating)
      get :index
      response.should render_template('index')
    end
    it "should show sorting by title when title" do
#      fake_result = [mock('Movie'), mock('Movie')]
#      rating = ["G", "PG", "PG-13", "NC-17", "R"]
      ratings = { "G" => "G", "PG" => "PG", "PG-13" => "PG-13",
                  "NC-17" => "NC-17", "R" => "R" }
#      Movie.stub(:all_ratings).and_return(rating)
#      Movie.stub(:find_all_by_rating).and_return(fake_result)
#      Movie.should_receive(:find_all_by_rating).with(rating, "title")
      get :index, :sort => "title"
      response.should redirect_to (movies_path(:ratings => ratings, :sort => 'title'))
    end
    it "should show sorting by release date when release date" do
      ratings = { "G" => "G", "PG" => "PG", "PG-13" => "PG-13",
                  "NC-17" => "NC-17", "R" => "R" }
      get :index, :sort => "release_date"
      response.should redirect_to (movies_path(:ratings => ratings, :sort => 'release_date'))
    end
  end

end

