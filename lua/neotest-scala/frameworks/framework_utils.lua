-- Declare the module table
local framework_utils = {}

--- Strip ANSI characters from the string, leaving the rest of the string intact.
---@param s string
---@return string
function framework_utils.strip_ainsi_chars(s)
    local v = s:gsub("\x1b%[%d+;%d+;%d+;%d+;%d+m", "")
        :gsub("\x1b%[%d+;%d+;%d+;%d+m", "")
        :gsub("\x1b%[%d+;%d+;%d+m", "")
        :gsub("\x1b%[%d+;%d+m", "")
        :gsub("\x1b%[%d+m", "")
    return v
end

--- Strip sbt info logging prefix from string.
---@param s string
---@return string
function framework_utils.strip_sbt_info_prefix(s)
    local v = s:gsub("^%[info%] ", "")
    return v
end

---@param project string
---@param runner string
---@param test_path string|nil
---@param extra_args table|string
---@return string[]
function framework_utils.build_command_with_test_path(project, runner, test_path, extra_args)
    if runner == "bloop" then
        local full_test_path
        if not test_path then
            full_test_path = {}
        else
            full_test_path = { "--", test_path }
        end
        return vim.tbl_flatten({ "bloop", "test", extra_args, project, full_test_path })
    end
    if not test_path then
        return vim.tbl_flatten({ "sbt", extra_args, project .. "/test" })
    end
    -- TODO: Run sbt with colors, but figure which ANSI sequence needs to be matched.
    return vim.tbl_flatten({
        "sbt",
        "--no-colors",
        extra_args,
        project .. "/testOnly -- " .. '"' .. test_path .. '"',
    })
end

-- Return the module table at the end
return framework_utils
