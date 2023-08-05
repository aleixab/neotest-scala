local frameworks = {
    munit = require("neotest-scala.frameworks.munit"),
    utest = require("neotest-scala.frameworks.utest"),
    scalatest = require("neotest-scala.frameworks.scalatest"),
}

local M = {}

TEST_PASSED = "passed" -- the test passed
TEST_FAILED = "failed" -- the test failed

---Returns a framework class.
---@param framework string
---@return neotest-scala.Framework|nil
function M.get_framework_class(framework)
    return frameworks[framework] and frameworks[framework]()
end

return M
