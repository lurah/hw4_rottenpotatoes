Given /the following movies exist:/ do |movies|
  movies.hashes.each { |movie| Movie.create(movie) }
end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
  Movie.find_by_title(title).director.should == director
end

