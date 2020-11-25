require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Ryan", email: "ryan@example.com")
    @recipe1 = @chef.recipes.create(name: "Vegetable Saute", description: "very tasty and good.")
    @recipe2 = @chef.recipes.create(name: "Tofu Saute", description: "very tasty and good.")
  end

  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe1.name, response.body
    assert_match @recipe2.name, response.body
  end
 
end
