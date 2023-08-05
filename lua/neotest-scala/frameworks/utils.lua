--- Strip ainsi characters from the string, leaving the rest of the string intact.
---@param s string
---@return string
local function strip_ainsi_chars(s)
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
local function strip_sbt_info_prefix(s)
    local v = s:gsub("^%[info%] ", "")
    return v
end

---@param project string
---@param runner string
---@param test_path string|nil
---@param extra_args table|string
---@return string[]
local function build_command_with_test_path(project, runner, test_path, extra_args)
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
    -- TODO: Run sbt with colors, but figuoure wich ainsi sequence need to be matched.
    return vim.tbl_flatten({
        "sbt",
        "--no-colors",
        extra_args,
        project .. "/testOnly -- " .. '"' .. test_path .. '"',
    })
end

--- ... function definitions ...

return {
    strip_ainsi_chars = strip_ainsi_chars,
    strip_sbt_info_prefix = strip_sbt_info_prefix,
    build_command_with_test_path = build_command_with_test_path
}

