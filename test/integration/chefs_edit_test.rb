require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Ryan", email: "ryan@example.com",
                         password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "Ryan2", email: "ryan2@example.com",
                         password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "Ryan3", email: "ryan3@example.com",
                         password: "password", password_confirmation: "password", admin: true)                    
  end

  test "reject invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "ryan@example.com" } }
    assert_template 'chefs/edit'
    assert_select 'div.panel-body'
  end

  test "accept valid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "ryan1", email: "ryan1@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload 
    assert_match "ryan1", @chef.chefname
    assert_match "ryan1@example.com", @chef.email
  end

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "ryan", email: "ryan@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload 
    assert_match "ryan", @chef.chefname
    assert_match "ryan@example.com", @chef.email
  end

  test "redirect edit attempt by a non-admin user" do
    sign_in_as(@chef2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email } }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload 
    assert_match "Ryan", @chef.chefname
    assert_match "ryan@example.com", @chef.email
  end

end
