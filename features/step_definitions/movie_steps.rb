# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    m = Movie.new
    m.title = movie[:title]
    m.rating = movie[:rating]
    m.release_date = movie[:release_date]
    m.save
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert false, "Unimplmemented"
end

Then /I should see all of the movies/ do
  Movie.find(:all).each { |m| 
    if page.respond_to? :should
      page.should have_content(m[:title])
    else
      assert page.has_content?(m[:title])
    end
  }
end

Then /I should not see any of the movies/ do
  Movie.find(:all).each { |m| 
    if page.respond_to? :should
      page.should have_no_content(m[:title])
    else
      assert page.has_no_content?(m[:title])
    end
  }
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each { |rating|
    rating = rating.strip

    if uncheck then
      uncheck(rating)
    else
      check(rating)
    end
  }
end
