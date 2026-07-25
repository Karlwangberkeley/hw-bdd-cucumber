# Add a declarative step here for populating the DB with movies.

Given(/the following movies exist/) do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  "Fill in this step in movie_steps.rb"
end

Then(/(.*) seed movies should exist/) do |n_seeds|
  expect(Movie.count).to eq n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then(/^I should see "(.*)" before "(.*)" in the movie list$/) do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body).to match(/#{e1}.*?#{e2}/m)
end

Then(/^I should (not )?see the following movies: (.*)$/) do |no, movie_list|
  # Take a look at web_steps.rb Then /^(?:|I )should see "([^"]*)"$/
  movies = movie_list.split(',').map(&:strip)
  movies.each do |movie|
    if no
      expect(page).not_to have_content(movie)
    else
      expect(page).to have_content(movie)
    end
  end
end

Then(/^I should see all the movies$/) do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    expect(page).to have_content(movie.title)
  end
end

### Utility Steps Just for this assignment.

Then(/^debug$/) do
  # Use this to write "Then debug" in your scenario to open a console.
  require "byebug"
  byebug
  1 # intentionally force debugger context in this method
end

Then(/^debug javascript$/) do
  # Use this to write "Then debug" in your scenario to open a JS console
  page.driver.debugger
  1
end

Then(/complete the rest of of this scenario/) do
  # This shows you what a basic cucumber scenario looks like.
  # You should leave this block inside movie_steps, but replace
  # the line in your scenarios with the appropriate steps.
  raise "Remove this step from your .feature files"
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # Split the rating_list by comma and remove surrounding whitespace
  ratings = rating_list.split(',').map(&:strip)
  
  ratings.each do |rating|
    # The checkboxes in the RottenPotatoes view are named like "ratings_PG", "ratings_R", etc.
    checkbox_name = "ratings_#{rating}"
    
    if uncheck
      uncheck(checkbox_name)
    else
      check(checkbox_name)
    end
  end

end