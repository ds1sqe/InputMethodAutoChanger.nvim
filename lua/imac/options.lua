-- Options for Plugin

local M = {}

function M.set(ime_target,ime_eng,debug_mode)
  vim.g.IME_Target=ime_target
  vim.g.IME_ENG=ime_eng
  vim.g.imac_DEBUGMODE=debug_mode
  vim.g.imac_OS=M.getOS()

  if vim.g.imac_DEBUGMODE==true then
    require("notify")("Options: Target:"..ime_target.." | Eng: "..ime_eng.." | Debug: "..tostring(debug_mode).. " | OS: "..vim.g.imac_OS)
  end
end
function M.getOS()
  local handle = io.popen("uname")
  local result = string.gsub(handle:read("*a"),"[\n\r]","")
  handle:close()
  if result=="Linux" then
    return result
  end if result=="Darwin" then
    return "Macos"
  end return "Windows"
end

return M
