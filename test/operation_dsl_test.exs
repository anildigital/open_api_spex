defmodule OpenApiSpex.OperationDslTest do
  use ExUnit.Case, async: true

  alias OpenApiSpexTest.DslController

  test "operation/1" do
    assert [
             show: %OpenApiSpex.Operation{
               responses: [],
               summary: "Show user",
               parameters: show_parameters,
               tags: show_tags
             },
             index: %OpenApiSpex.Operation{
               responses: [],
               summary: "User index",
               parameters: index_parameters
             }
           ] = DslController.spec_attributes()

    assert show_tags == ["users"]

    assert [
             %OpenApiSpex.Parameter{
               description: "User ID",
               example: 1001,
               in: :path,
               name: :id,
               required: true,
               schema: %OpenApiSpex.Schema{type: :integer}
             }
           ] = show_parameters

    assert [
             %OpenApiSpex.Parameter{
               description: "Free-form query string",
               example: "jane",
               in: :query,
               name: :query,
               schema: %OpenApiSpex.Schema{type: :string}
             }
           ] = index_parameters
  end
end
