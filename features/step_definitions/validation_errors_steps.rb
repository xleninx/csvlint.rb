When(/^I ask if there are errors$/) do
  @csv_options ||= default_csv_options
  @validator = Csvlint::Validator.new( @url, @csv_options ) 
  @errors = @validator.errors
end

Then(/^there should be (\d+) error$/) do |count|  
  @errors.count.should == count.to_i
end

Then(/^that error should have the type "(.*?)"$/) do |type|
  @errors.first.type.should == type.to_sym
end

Then(/^that error should have the row "(.*?)"$/) do |row|
  @errors.first.row.should == row.to_i
end

Then(/^that error should have the content "(.*)"$/) do |content|
  @errors.first.content.chomp.should == content.chomp
end

Then(/^that error should have no content$/) do
  @errors.first.content.should == nil
end

Given(/^I have a CSV that doesn't exist$/) do
  @url = "http//www.example.com/fake-csv.csv"
  stub_request(:get, @url).to_return(:status => 404)
end

Then(/^there should be no "(.*?)" errors$/) do |type|
  @errors.each do |error| error.type.should_not == type.to_sym end
end

Given(/^I have a CSV with carriage returns in fields$/) do
  @csv = "\"Foo\",\"Bar\",\"Baz\"\r\n\"Bing\",\"Bang\nBung\",\"Bong\""
end