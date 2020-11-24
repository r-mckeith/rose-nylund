require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.create(chefname: "Ryan", email: "ryan@example.com")
    @recipe = @chef.recipes.build(name: "Tofu", description: "Is really tasty and good")
  end

  test "recipe should be valid" do 
    assert @recipe.valid?
  end

  test "name should be present" do
    assert @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "description should be present" do
    assert @recipe.description = " "
    assert_not @recipe.valid?
  end

  test "description should be at least 5 characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end

  test "description should be no more than 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
end