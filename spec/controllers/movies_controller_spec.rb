require 'spec_helper'

describe MoviesController do

  describe "Find Movie With Same Director" do
    it "should call the model method that performs find similar movie" do
      Movie.should_receive(:search).with("1")
      get :find_similar, :id => 1
    end
    it "should select the Search Result template for rendering" do
      Movie.stub(:search)
      get :find_similar, :id => 1
      response.should render_template('find_similar')
    end
    it "should make the Search Result available to the template" do
      fake_result = [mock('Movie'), mock('Movie')]
      Movie.stub(:search).and_return(fake_result)
      get :find_similar, :id => 1
      assigns(:movies).should == fake_result
    end
  end
end

