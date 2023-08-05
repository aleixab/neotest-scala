local frameworks = {
    utest = require("neotest-scala.frameworks.utest"),
    munit = require("neotest-scala.frameworks.munit"),
    scalatest = require("neotest-scala.frameworks.scalatest"),
}

TEST_PASSED = "passed"
TEST_FAILED = "failed"

---@class neotest-scala.Framework
---@field build_command fun(runner: string, project: string, tree: neotest.Tree, name: string, extra_args: table|string): string[]
---@field get_test_results fun(output_lines: string[]): table<string, string>
---@field match_func nil|fun(test_results: table<string, string>, position_id :string):string|nil

---Returns a framework class.
---@param framework string
---@return neotest-scala.Framework|nil
local function get_framework_class(framework)
    return frameworks[framework]
end

return {
    get_framework_class = get_framework_class,
}
