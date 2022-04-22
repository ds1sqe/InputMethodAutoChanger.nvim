-- Object
local M = {}

-- Get current IME
-- function M:getOS()
--   local handle = io.popen("uname")
--   local result = handle:read("*a")
--   handle:close()
--   return tostring(result)
-- end

function M:get_language()
  -- if M:getOS()=="Linux"then
    require("cjk.linux").get_language()
  -- end if M:getOS()=="Darwin"then
  --   require("macos").get_language()
  -- end
end

-- Set language, use ConvertKey or IME
-- @param IME => InputMethod that want to covert to
-- @param convertKey => Key for converting
-- TODO add Mac and Windows scripts
function M:set_lang(IME,convertKey)
  -- if M:getOS()=="Linux"then
    require('cjk.linux').set_lang(IME,convertKey)
  -- end if M:getOS()=="Darwin"then
  --   require('macos').set_lang(IME,convertKey)
  -- end
end

-- Check if input in CJK, if then, Raise Flag
-- and convert IME to Eng
function M:InputToNormal()
    vim.g.inputInCjk = (M.get_language()==vim.g.IME_CJK)
    M.set_lang(vim.g.IME_ENG,vim.g.convertKey)
end


-- Automatically convert to CJK if you exited inputmod with CJK
function M:NormalToInput()
    if vim.g.inputInCjk == true then
      M.set_lang(vim.g.IME_CJK,vim.g.convertKey)
  end
end

return M
