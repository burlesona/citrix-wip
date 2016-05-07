require 'test_helper'

class CurrentUserTest < ActiveSupport::TestCase
  test "works with nil user" do
    cu = CurrentUser.new
    assert_equal false, cu.logged_in?
    assert_equal false, cu.admin?
    assert_equal nil, cu.id
    assert_equal nil, cu.username
    assert_equal nil, cu.email
    assert_equal nil, cu.first_name
    assert_equal nil, cu.last_name
  end

  test "works with regular user" do
    u = users(:regular)
    cu = CurrentUser.new(u)
    assert_equal true, cu.logged_in?
    assert_equal false, cu.admin?
    refute_equal nil, cu.id
    assert_equal 'regular', cu.username
    assert_equal 'regular@example.com', cu.email
    assert_equal 'Regular', cu.first_name
    assert_equal 'User', cu.last_name
  end

  test "works with admin user" do
    u = users(:admin)
    cu = CurrentUser.new(u)
    assert_equal true, cu.logged_in?
    assert_equal true, cu.admin?
    refute_equal nil, cu.id
    assert_equal 'admin', cu.username
    assert_equal 'admin@example.com', cu.email
    assert_equal 'Admin', cu.first_name
    assert_equal 'User', cu.last_name
  end

  test "equality" do
    reg = users(:regular)
    adm = users(:admin)
    cu_nil = CurrentUser.new
    cu_reg = CurrentUser.new(reg)
    cu_adm = CurrentUser.new(adm)

    assert_equal cu_nil, cu_nil
    refute_equal cu_nil, reg
    refute_equal cu_nil, adm
    refute_equal cu_nil, cu_reg
    refute_equal cu_nil, cu_adm

    assert_equal cu_reg, cu_reg
    assert_equal cu_reg, reg
    refute_equal cu_reg, cu_adm
    refute_equal cu_reg, adm
  end
end
