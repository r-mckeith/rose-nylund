require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Ryan", email: "ryan@example.com",
                         password: "password", password_confirmation: "password")
    @recipe = @chef.recipes.create(name: "Vegetable saute", description: "very tasty and good.")
    @recipe2 = @chef.recipes.create(name: "Tofu Saute", description: "very tasty and good.")
  end

  test "should get chef's show" do 
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end

end
