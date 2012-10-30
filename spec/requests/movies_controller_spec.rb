require "spec_helper"

describe "MoviesController" do

  describe "Find Movie With Same Director" do
    it "should call the model method that performs find similar movie" do
      Movie.should_receive(:search).with("1")
      get "/movies/1/find_similar"
    end
    it "should select the Search Result template for rendering"
    it "should make the Search Result available to the template"
  end

end

