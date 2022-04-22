-- Object
local M = {}

-- Constructer
-- @param IME_CJK => target Languge, Non Eng, ex) xkb:jp::jpn - Japannese
-- @param IME_ENG => English IME ex) xkb:us::eng, if IME_CJK and IME_ENG provided, convertKey doen't need
-- @param convertKey => Key for toggling ENG/CJK
function M:new(IME_CJK,IME_ENG,convertKey)

  -- define CJK IME
  self.cjk_Lang = IME_CJK
  vim.api.notify("construter : Input Method for CJK is " .. self.cjk_Lang)

  -- define English IME
  self.eng_Lang= IME_ENG
  vim.api.notify("construter : Input Method for ENG is " .. self.eng_Lang)
  -- Key Define
  self.convertKey = convertKey
  vim.api.notify("construter : convertKey is" .. self.convertKey)
  -- Flag for converting
  self.InputInCjk = false

  return self
end

-- Get current IME
function M:get_language()
  if M:getOS()=="Linux"then
    require("linux").get_language()
  end if M:getOS()=="Darwin"then
    require("macos").get_language()
  end
end

function M:getOS()
    return os.execute("uname")
end

-- Set language, use ConvertKey or IME
-- @param IME => InputMethod that want to covert to
-- @param convertKey => Key for converting
-- TODO add Mac and Windows scripts
function M:set_lang(IME,convertKey)
  if M:getOS()=="Linux"then
    require('linux').set_lang(IME,convertKey)
  end if M:getOS()=="Darwin"then
    require('macos').set_lang(IME,convertKey)
  end
end

-- Check if input in CJK, if then, Raise Flag
-- and convert IME to Eng
function M:InputToNormal()
    vim.g.inputInCjk = (self.get_language()==self.cjk_Lang)
    vim.api.notify("Languge flag toggled")
    self.set_lang(self.eng_Lang,false)
end


-- Automatically convert to CJK if you exited inputmod with CJK
function M:NormalToInput()
    if vim.g.inputInCjk == true then
      self.set_lang(self.cjk_Lang,self.convertKey)
      vim.api.notify("Languge converted")
  end
end

return M
