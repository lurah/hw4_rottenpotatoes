require 'spec_helper'

describe Movie do

  it "has valid factory" do
    FactoryGirl.create(:movie).should be_valid
  end

  it "should create 3 aditional record" do
    movies = []
    movies << FactoryGirl.create(:movie, :title => "Movie1", :director => "AA")
    movies << FactoryGirl.create(:movie, :title => "Movie2", :director => "AA")
    FactoryGirl.create(:movie, :title => "Movie3", :director => "BB")
    Movie.all.count.should == 3
    id = Movie.find_by_title("Movie1").id
    Movie.search(id).should == movies
  end

end
