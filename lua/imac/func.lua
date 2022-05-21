local M={}

if vim.g.imac_linux==true then
  M=require("imac.linux")
end if vim.g.imac_macos == true then
  M=require("imac.macos")
end if vim.g.imac_windows ==true then
  M=require("imac.window")
end

M.set()

--Check if input in imac, if then, Raise Flag
--and convert IME to Eng
function M.InputToNormal()
  local currentLang = M.get_language()
  if vim.g.imac_DEBUGMODE==true then
    require("notify")("imac.func: Currentlang : " .. currentLang .. " | type :" .. type(currentLang))
    require("notify")("->: Ime imac : " .. vim.g.IME_Target .. " | type :" .. type(vim.g.IME_Target))
    require("notify")("->: Current, Target, : " .. currentLang ..vim.g.IME_Target )
    require("notify")("->inputinTarget" .. tostring((vim.g.IME_Target) ==(currentLang)))
  end
  if currentLang == vim.g.IME_Target then
    vim.g.inputInTarget = true
  else
    vim.g.inputInTarget = false
  end
  if vim.g.imac_DEBUGMODE==true then
   require("notify")("imacfunction: Input in imac = " .. tostring(vim.g.inputInTarget))
  end
  if vim.g.inputInTarget == true then
    M.set_lang(vim.g.IME_ENG)
  end
end

-- Automatically convert to imac if you exited inputmod with imac
function M.NormalToInput()
  if vim.g.imac_DEBUGMODE==true then
    require("notify")("imacfunction: Input in imac = " .. tostring(vim.g.inputInTarget))
  end
    if vim.g.inputInTarget == true then
      M.set_lang(vim.g.IME_Target)
  end
end
return M
