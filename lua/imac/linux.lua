-- Scripts for Linux
-- If you use linux, have to use ibus for till now.
-- TODO Mulitiple IME Support ex) fctix

local M = {}

function M.set_lang(inputMethoad)
  if inputMethoad ~= "" then
    os.execute("ibus engine " .. inputMethoad)
    if vim.g.imac_DEBUGMODE == true then
      print("imac.linux(set) : ibus engine " .. inputMethoad)
    end
  end
end

function M.get_language()
  local handle = io.popen("ibus engine")
  if handle ~= nil then
    local result = string.gsub(handle:read("*a"), "[\n\r]", "")
    handle:close()
    if vim.g.imac_DEBUGMODE == true then
      print("imac.linux(get) : ibus engine " .. result)
      return result
    end
  end
  return nil
end

function M.set()
  if vim.g.IME_ENG == "" then
    vim.g.IME_ENG = "xkb:us::eng"
  end
  if vim.g.IME_Target == "hangul" then
    os.execute('gsettings set org.freedesktop.ibus.engine.hangul off-keys \'\'')
  end
end

return M
