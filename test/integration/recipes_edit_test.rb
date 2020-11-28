require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Ryan", email: "ryan@example.com",
                         password: "password", password_confirmation: "password")
    @recipe = @chef.recipes.create(name: "Vegetable saute", description: "very tasty and good.")
  end

  test "a valid recipe is updated" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "updated recipe name"
    updated_description = "updated recipe description"
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_description } }
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end

  test "an invalid recipe is not updated" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", dewcription: "some description" } }
    assert_template 'recipes/edit'
    assert_select 'div.panel-body'
  end
     
end
