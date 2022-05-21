--script for windows

local M = {}


function M.set_lang(inputMethoad)
  os.execute(vim.g.imSelectPath .. " " .. inputMethoad)
end

function M.get_language()
    local handle = io.popen()
    local result = string.gsub(handle:read("*a"),"[\n\r]","")
    handle:close()
    return result
end

function M.set()
  --
end

return M
