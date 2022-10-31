--script for windows

local M = {}


function M.set_lang(inputMethoad)
  os.execute(vim.g.imSelectPath .. " " .. inputMethoad)
end

function M.get_language()
  local handle = io.popen(vim.g.imSelectPath)
  if handle ~= nil then
    local result = string.gsub(handle:read("*a"), "[\n\r]", "")
    handle:close()
    return result
  else
    -- error
  end
end

function M.set()
  local handle = io.popen("echo %USERPROFILE%")
  if handle ~= nil then
    local result = string.gsub(handle:read("*a"), "[\n\r]", "")
    handle:close()
    vim.g.imSelectPath = result
    if vim.g.IME_Target == "" then
      -- FIXME ,have to add a IME for Windows default
      vim.g.IME_Target = "IME_Target"
    end
    if vim.g.IME_ENG == "" then
      vim.g.IME_ENG = "IME_ENG"
    end
  end
  -- FIXME
end

return M
