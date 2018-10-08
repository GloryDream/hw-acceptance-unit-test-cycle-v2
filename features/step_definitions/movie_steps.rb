Given /^the following movies exist:$/ do |table|
  table.hashes.each do |hash|
    Movie.create hash
  end
end

Then /^the director of "(.*)" should be "(.*)"$/ do |title_value, director_value|
  movie = Movie.find_by_title(title_value)
  expect(movie.director).to eq(director_value)
end

# Then /^the director of "(.+)" should be "(.+)"/ do |movie_name, director|
#   movie = Movie.find_by(title: movie_name)
#   visit movie_path(movie)
#   expect(page.body).to match(/Director:\s#{director}/)
# end
