
-- Scripts for Linux
-- If you use linux, have to use ibus for till now.
-- TODO Mulitiple IME Support ex) fctix

local M = {}

function M.set_lang(inputMethoad)
  if inputMethoad ~= "" then
    os.execute("ibus engine " .. inputMethoad)
    if vim.g.imac_DEBUGMODE == true then
      require("notify")("Linux(set) : ibus engine "..inputMethoad)
    end
  end
end

function M.get_language()
    local handle = io.popen("ibus engine")
    local result = string.gsub(handle:read("*a"),"[\n\r]","")
    handle:close()
      if vim.g.imac_DEBUGMODE == true then
    require("notify")("Linux(get) : ibus engine " .. result)
    end
  return result
end

function M.set()
  os.execute('gsettings set org.freedesktop.ibus.engine.hangul off-keys \'\'')
end

return M