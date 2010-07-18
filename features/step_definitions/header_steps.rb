Given /^I have the following headers$/ do |table|
  table.hashes.each do |hash|
    Factory(:product, :item_number => hash['item number'],
      :header_type => HeaderType.find_by_name(hash['type'], :first),
      :published => hash['published'] == 'yes' ? true : false)
  end
end

Then /^I should have ([0-9]+) headers?$/ do |count|
  Header.count.should == count.to_i
end