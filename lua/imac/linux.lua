-- Scripts for Linux
-- If you use linux, have to use ibus for till now.
-- TODO Mulitiple IME Support ex) fctix

local M = {
  ime = "ibus",
}

function M.setup(config)
  M.config = config
  M.check_ime()
  if M.ime == "ibus" then
    if M.config.linux.ibus.IME_Target == "hangul" then
      os.execute('gsettings set org.freedesktop.ibus.engine.hangul off-keys \'\'')
    end
  end
end

function M.check_ime()
  local ibus = io.popen("ibus")
  if ibus ~= nil then
    local result = string.gsub(ibus:read("*a"), "[\n\r]", "")
    if result ~= "" then
      M.ime = "ibus"
    end
  end
  local fcitx = io.popen("fcitx5-remote")
  if fcitx ~= nil then
    local result = string.gsub(fcitx:read("*a"), "[\n\r]", "")
    if result ~= "" then
      M.ime = "fcitx"
    end
  end
  if M.config.debug then
    print("IMAC> ime : " .. M.ime)
  end
end

function M.check_mode()
  if M.ime == "ibus" then
    local handle = io.popen("ibus engine")
    if handle ~= nil then
      local result = string.gsub(handle:read("*a"), "[\n\r]", "")
      handle:close()
      return result == M.config.linux.ibus.IME_Target
    end
    if M.config.debug then
      print("handle is nil (ibus)")
    end
  elseif M.ime == "fcitx" then
    local fcitx = io.popen("fcitx5-remote -n")
    if fcitx ~= nil then
      local result = string.gsub(fcitx:read("*a"), "[\n\r]", "")
      return result == M.config.linux.fcitx.IME_Target
    end
    if M.config.debug then
      print("handle is nil (fcitx)")
    end
  end
  return false
end

function M.to_eng()
  if M.ime == "ibus" then
    os.execute("ibus engine " .. M.config.linux.ibus.IME_ENG)
  elseif M.ime == "fcitx" then
    os.execute("fcitx5-remote -s " .. M.config.linux.fcitx.IME_ENG)
  end
end

function M.to_target()
  if M.ime == "ibus" then
    os.execute("ibus engine " .. M.config.linux.ibus.IME_Target)
  elseif M.ime == "fcitx" then
    os.execute("fcitx5-remote -s " .. M.config.linux.fcitx.IME_Target)
  end
end

return M
