require 'test_helper'

class DiaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dia = dia(:one)
  end

  test "should get index" do
    get dia_index_url
    assert_response :success
  end

  test "should get new" do
    get new_dia_url
    assert_response :success
  end

  test "should create dia" do
    assert_difference('Dia.count') do
      post dia_index_url, params: { dia: {  } }
    end

    assert_redirected_to dia_url(Dia.last)
  end

  test "should show dia" do
    get dia_url(@dia)
    assert_response :success
  end

  test "should get edit" do
    get edit_dia_url(@dia)
    assert_response :success
  end

  test "should update dia" do
    patch dia_url(@dia), params: { dia: {  } }
    assert_redirected_to dia_url(@dia)
  end

  test "should destroy dia" do
    assert_difference('Dia.count', -1) do
      delete dia_url(@dia)
    end

    assert_redirected_to dia_index_url
  end
end
