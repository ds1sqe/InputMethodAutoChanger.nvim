-- Options for Plugin

local M = {}

function M.set(ime_target,ime_eng,debug_mode)
  vim.g.IME_Target=ime_target
  if ime_eng~= "" then
    vim.g.IME_ENG=ime_eng
  end
  vim.g.imac_DEBUGMODE=debug_mode

  M.getOS()

  if vim.g.imac_DEBUGMODE==true then
    require("notify")("Options: Target:"..ime_target.." | Eng: "..ime_eng.." | Debug: "..tostring(debug_mode) )
  end
end

function M.getOS()
  local handle = io.popen("uname")
  local result = string.gsub(handle:read("*a"),"[\n\r]","")
  handle:close()
  if result=="Linux" then
    vim.g.imac_linux=true
    return
  end if result=="Darwin" then
    vim.g.imac_macos=true
    return
  end
    vim.g.imac_windows=true
end

return M
