-- Scripts for linux os
-- If you use linux, have to use ibus
-- TODO Mulitiple Language/ IME Support

local M = {}

function M:set_lang(IME,convert_key)
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

function M:get_language()
    return os.execute('ibus engine')
end

function M:set()
  os.execute('gsettings set org.freedesktop.ibus.engine.hangul off-keys \'\'')
end

return M

