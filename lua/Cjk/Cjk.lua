--  ██████╗     ██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
-- ██╔════╝     ██║██║ ██╔╝██║   ██║██║████╗ ████║
-- ██║          ██║█████╔╝ ██║   ██║██║██╔████╔██║
-- ██║     ██   ██║██╔═██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
-- ╚██████╗╚█████╔╝██║  ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
--  ╚═════╝ ╚════╝ ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
-- For CJK user who want to input non-eng languge
-- @auther ds1sqe@mensakorea.org

-- Global Object
CJK_Plugin = {}

-- Global Constructer
function CJK_Plugin:new(cjkTargetLang,convertKey)

  -- define target language
  self.cjk_Lang = "korean" or cjkTargetLang

  -- Key Define
  self.convertKey = "Hangul" or convertKey
  -- or ConvertKey = "Ctrl + Space"

  -- Flag for converting
  self.InputInCjk = false

  return self

end

  -- Set language
function CJK_Plugin:set_lang(convert_key)
    os.execute("xdotool key" .. convert_key)
end

  -- check if input in CJK, if then, Raise Flag
function CJK_Plugin:InputToNormal()
    self.InputInCJK= (self.get_language()==self.cjk_Lang)
end

  -- Gets current languge returns that.
function CJK_Plugin:NormalToInput()
    if self.InputInCJK == true then
      self.set_lang(self.convertKey)
  end
end

  -- Check input mod's language
function CJK_Plugin:get_language()
    return os.execute('ibus engine')
end

-- on input mode to NormalMode,
-- CJK_Plugin.CjkInputToNormalCheck()
-- on NormalMode to inputMode,
-- CJK_Plugin.CjkToInput()

