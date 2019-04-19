require 'test_helper'

class BitModuleNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bit_module_name = bit_module_names(:one)
  end

  test "should get index" do
    get bit_module_names_url
    assert_response :success
  end

  test "should get new" do
    get new_bit_module_name_url
    assert_response :success
  end

  test "should create bit_module_name" do
    assert_difference('BitModuleName.count') do
      post bit_module_names_url, params: { bit_module_name: { author: @bit_module_name.author, date_added: @bit_module_name.date_added, last_modified: @bit_module_name.last_modified, sub_topic_five: @bit_module_name.sub_topic_five, sub_topic_four: @bit_module_name.sub_topic_four, sub_topic_one: @bit_module_name.sub_topic_one, sub_topic_three: @bit_module_name.sub_topic_three, sub_topic_two: @bit_module_name.sub_topic_two } }
    end

    assert_redirected_to bit_module_name_url(BitModuleName.last)
  end

  test "should show bit_module_name" do
    get bit_module_name_url(@bit_module_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_bit_module_name_url(@bit_module_name)
    assert_response :success
  end

  test "should update bit_module_name" do
    patch bit_module_name_url(@bit_module_name), params: { bit_module_name: { author: @bit_module_name.author, date_added: @bit_module_name.date_added, last_modified: @bit_module_name.last_modified, sub_topic_five: @bit_module_name.sub_topic_five, sub_topic_four: @bit_module_name.sub_topic_four, sub_topic_one: @bit_module_name.sub_topic_one, sub_topic_three: @bit_module_name.sub_topic_three, sub_topic_two: @bit_module_name.sub_topic_two } }
    assert_redirected_to bit_module_name_url(@bit_module_name)
  end

  test "should destroy bit_module_name" do
    assert_difference('BitModuleName.count', -1) do
      delete bit_module_name_url(@bit_module_name)
    end

    assert_redirected_to bit_module_names_url
  end
end
