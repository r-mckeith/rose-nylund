require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
 
  def setup
    @chef = Chef.create!(chefname: "Ryan", email: "ryan@example.com")
    @recipe = @chef.recipes.create(name: "Vegetable saute", description: "very tasty and good.")
  end

  test "succesfully delete a recipe" do 
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete recipe"
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end

end
