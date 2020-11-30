require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Ryan", email: "ryan@example.com",
                         password: "password", password_confirmation: "password")
    @recipe = @chef.recipes.create(name: "Vegetable saute", description: "very tasty and good.")
    @recipe2 = @chef.recipes.create(name: "Tofu Saute", description: "very tasty and good.")
  end

  test "should get chefs index" do
    get chefs_url
    assert_response :success
  end

  test "should delete chef" do
    sign_in_as(@chef, "password")
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef)
    end
    assert_redirected_to chefs_path 
    assert_not flash.empty?
  end
  

  test "should get chef's show page" do 
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end

end
