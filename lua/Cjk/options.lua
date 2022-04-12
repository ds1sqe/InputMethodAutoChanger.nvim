-- Options for Plugin

local Opt = {}

-- defaultOptions
local defaultOptions={IME_CJK = "korean",IME_ENG = "xkb:us::eng",convertKey =false}

local options= {}

function Opt.set(userOptions)
  local user_fallback_options = userOptions or {}
  options = vim.tbl_deep_extend("force",user_fallback_options,defaultOptions)
end
function Opt.get()
  return options
end
return Opt
