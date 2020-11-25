require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Ryan", email: "ryan@example.com")
    @recipe = @chef.recipes.create(name: "Vegetable saute", description: "very tasty and good.")
    @recipe2 = @chef.recipes.create(name: "Tofu Saute", description: "very tasty and good.")
  end

  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name

  end

  test "should link to recipe show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body 
    assert_match @recipe.description, response.body 
    assert_match @chef.chefname, response.body 
  end

end
