require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "Ryan", email: "Ryan@example.com",
                     password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @chef.valid?
  end

  test "name should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "should be less than 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email should be less than 50 characters" do
    @chef.email = "a" * 51
    assert_not @chef.valid?
  end

  test "should accept valid email addresses" do
    valid_emails = %w[user@example.com RYAN@gmail.com craZygUrl69@aol.com]
    valid_emails.each do |validates| 
      @chef.email = validates
      assert @chef.valid?, "#{validates.inspect} should be valid"
    end
  end

  test "should reject invalid email addresses" do
    invalid_emails = %w[ryan@example ryan@example,com ryan@name.]
    invalid_emails.each do |invalidates|
      @chef.email = invalidates
      assert_not @chef.valid?, "#{invalidates.inspect} should be invalid"
    end
  end

  test "email should be unique and case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "email should be lowercase before hitting the database" do
    mixed_email = "RyaN@example.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end

  test "password should be present" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end

  test "password should be at least 5 characters" do
    @chef.password = @chef.password_confirmation = "x" * 4
    assert_not @chef.valid?
  end

  test "associated recipes should be destroyed when chef is deleted" do
    @chef.save
    @chef.recipes.create!(name: "testing destroy", description: "let us see if this works")
    assert_difference 'Recipe.count', -1 do
      @chef.destroy
    end
  end

end

