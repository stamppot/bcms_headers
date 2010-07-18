require "spec_helper"

describe "Header Type" do

  it "should have a unique name" do
    # Header Type should not be valid without a name
    header_type = HeaderType.new
    header_type.should_not be_valid

    # Header Type should be valid once named
    header_type.name = 'Shawl'
    header_type.should be_valid
    header_type.save

    # A Header Type with the same name should not be valid
    header_type = HeaderType.new :name => 'Shawl'
    header_type.should_not be_valid

    # When the name is changed it should be valid
    header_type.name = 'Rug'
    header_type.should be_valid
  end
end
