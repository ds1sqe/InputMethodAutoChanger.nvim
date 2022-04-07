local autocmds = require "core.autocmds"

-- For CJK user who want to input non-eng languge


function AutoModeTogleCJK(cjkTargetLang,convertKey)
  -- Key Define
  local convertKey = "Hangul"
  -- or ConvertKey = "Ctrl + Space"

  -- Global Flag
  InputInCjk = false

  local cjk_Lang = "korean" or cjkTargetLang

  -- Gets current languge returns that.
  local function get_language()
    -- Check input mod's language
    return os.execute('ibus engine')
  end

  -- Set language
  local function set_lang(convert_key)
    return os.execute("xdotool key" .. convert_key)
  end

  -- if input in CJK, Raise Flag

  local function CjkInputToNormalCheck()
    InputInCJK= (get_language()==cjk_Lang)
  end

  function CjkToInput()
    if InputInCJK == true then
      set_lang(convertKey)
    end
  end
end


CJK_Plugin=AutoModeTogleCJK:new("korean","Hangul")

Autocmd=autocmds

-- on input mode to NormalMode,
-- CJK_Plugin.CjkInputToNormalCheck()
-- on NormalMode to inputMode,
-- CJK_Plugin.CjkToInput()
