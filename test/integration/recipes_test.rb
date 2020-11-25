require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end
 
end
