require 'test_helper'

class BitModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bit_module = bit_modules(:one)
  end

  test "should get index" do
    get bit_modules_url
    assert_response :success
  end

  test "should get new" do
    get new_bit_module_url
    assert_response :success
  end

  test "should create bit_module" do
    assert_difference('BitModule.count') do
      post bit_modules_url, params: { bit_module: { author: @bit_module.author, date_added: @bit_module.date_added, last_modified: @bit_module.last_modified, name: @bit_module.name, sub_topic_five: @bit_module.sub_topic_five, sub_topic_four: @bit_module.sub_topic_four, sub_topic_one: @bit_module.sub_topic_one, sub_topic_three: @bit_module.sub_topic_three, sub_topic_two: @bit_module.sub_topic_two } }
    end

    assert_redirected_to bit_module_url(BitModule.last)
  end

  test "should show bit_module" do
    get bit_module_url(@bit_module)
    assert_response :success
  end

  test "should get edit" do
    get edit_bit_module_url(@bit_module)
    assert_response :success
  end

  test "should update bit_module" do
    patch bit_module_url(@bit_module), params: { bit_module: { author: @bit_module.author, date_added: @bit_module.date_added, last_modified: @bit_module.last_modified, name: @bit_module.name, sub_topic_five: @bit_module.sub_topic_five, sub_topic_four: @bit_module.sub_topic_four, sub_topic_one: @bit_module.sub_topic_one, sub_topic_three: @bit_module.sub_topic_three, sub_topic_two: @bit_module.sub_topic_two } }
    assert_redirected_to bit_module_url(@bit_module)
  end

  test "should destroy bit_module" do
    assert_difference('BitModule.count', -1) do
      delete bit_module_url(@bit_module)
    end

    assert_redirected_to bit_modules_url
  end
end
