-- Object for return
local M = {}

-- Get current IME
function M.get_language()
  local result=""
  if vim.g.imac_OS=="Linux" then
    result= require("imac.linux").get_language()
  end if vim.g.imac_OS=="Macos" then
    result= require("imac.macos").get_language()
  end if vim.g.imac_OS=="Windows" then
    result= require("imac.window").get_language()
  end
  if vim.g.imac_DEBUGMODE==true then
     require("notify")("imac.func : result :".. result)
  end
  return result
end

-- Set language, use ConvertKey or IME
-- @param IME => InputMethod that want to covert to
-- TODO add Mac and Windows scripts
function M.set_lang(inputMethoad)
  if vim.g.imac_OS=="Linux" then
    require("imac.linux").set_lang(inputMethoad)
  end if vim.g.imac_OS=="Macos" then
    require("imac.macos").set_lang(inputMethoad)
  end if vim.g.imac_OS=="Windows" then
    require("imac.window").set_lang(inputMethoad)
  end
  if vim.g.imac_DEBUGMODE==true then
    require("notify")("imac.func: Set lang, " .. inputMethoad)
  end
end

--Check if input in imac, if then, Raise Flag
--and convert IME to Eng
function M.InputToNormal()
  local currentLang = M.get_language()
  if vim.g.imac_DEBUGMODE==true then
    require("notify")("imac.funcn: Currentlang : " .. currentLang .. " | type :" .. type(currentLang))
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
