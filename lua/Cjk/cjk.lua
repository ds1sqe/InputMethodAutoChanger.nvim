
--  ██████╗     ██╗██╗  ██╗   ██╗     ██╗   ██╗ █████╗
-- ██╔════╝     ██║██║ ██╔╝   ██║     ██║   ██║██╔══██╗
-- ██║          ██║█████╔╝    ██║     ██║   ██║███████║
-- ██║     ██   ██║██╔═██╗    ██║     ██║   ██║██╔══██║
-- ╚██████╗╚█████╔╝██║  ██╗██╗███████╗╚██████╔╝██║  ██║
--  ╚═════╝ ╚════╝ ╚═╝  ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
-- For CJK user who want to autoconvert between ENG and CJK
-- @auther ds1sqe@mensakorea.org

-- Object
local CJK_Plugin = {}

-- Constructer
-- @param IME_CJK => target Languge, Non Eng, ex) xkb:jp::jpn - Japannese
-- @param IME_ENG => English IME ex) xkb:us::eng, if IME_CJK and IME_ENG provided, convertKey doen't need
-- @param convertKey => Key for toggling ENG/CJK
function CJK_Plugin:new(IME_CJK,IME_ENG,convertKey)
  -- define CJK IME
  self.cjk_Lang = IME_CJK
  print("construter : Input Method for CJK is " .. self.cjk_Lang)

  -- define English IME
  self.eng_Lang= IME_ENG
  print("construter : Input Method for ENG is " .. self.eng_Lang)
  -- Key Define
  self.convertKey = convertKey
  print("construter : convertKey is" .. self.convertKey)
  -- or ConvertKey = "Ctrl + Space"

  -- Flag for converting
  self.InputInCjk = false

  return self
end
-- Internal function

-- Set language, use ConvertKey or IME
-- @param IME => InputMethod that want to covert to
-- @param convertKey => Key for converting
function CJK_Plugin:set_lang(IME,convert_key)
  local key = convert_key or false
  local ime = IME or false
  if ime ~= false then
    os.execute("ibus engine " .. ime)
    return true
  end
  if key ~= false then
    os.execute("xdotool key " .. convert_key)
    return false
  end
end

-- Get current IME
function CJK_Plugin:get_language()
    return os.execute('ibus engine')
end

-- Check if input in CJK, if then, Raise Flag
-- and convert IME to Eng
function CJK_Plugin:InputToNormal()
    self.InputInCJK= (self.get_language()==self.cjk_Lang)
    print("Languge flag toggled")
    self.set_lang(self.eng_Lang,false)
end

-- Automatically convert to CJK if you exited inputmod with CJK
function CJK_Plugin:NormalToInput()
    if self.InputInCJK == true then
      self.set_lang(self.cjk_Lang,self.convertKey)
      print("Languge converted")
  end
end

return CJK_Plugin
