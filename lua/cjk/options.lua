-- Options for Plugin

local M = {}

-- defaultOptions
local defaultOptions={IME_CJK = "korean",IME_ENG = "xkb:us::eng",convertKey =false}

local options= {}
function M.set(userOptions)
  local user_fallback_options = userOptions or {}
  options = vim.tbl_deep_extend("force",user_fallback_options,defaultOptions)
  vim.g.IME_CJK=options.IME_CJK
  vim.g.IME_ENG=options.IME_ENG
  vim.g.convertKey=options.convertKey
end
return M

