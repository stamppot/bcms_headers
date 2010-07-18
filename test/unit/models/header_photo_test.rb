require File.join(File.dirname(__FILE__), '/../../test_helper')

class HeaderPhotoTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert HeaderPhoto.create!
  end

end