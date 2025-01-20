-- Scripts for macos

local M = {}

function M.setup(config)
  M.config = config
  if os.execute("which im-select") == 1 then
    os.execute("brew tap daipeihust/tap && brew install im-select")
  end
end

function M.check_mode()
  return M.get_language() == M.config.macos.IME_Target
end

function M.to_eng()
  M.set_lang(M.config.macos.IME_ENG)
end

function M.to_target()
  M.set_lang(M.config.macos.IME_Target)
end

function M.set_lang(inputMethoad)
  if inputMethoad ~= "" then
    os.execute("/usr/local/bin/im-select " .. inputMethoad)
  end
end

function M.get_language()
  local handle = io.popen("/usr/local/bin/im-select")
  if handle ~= nil then
    local result = string.gsub(handle:read("*a"), "[\n\r]", "")
    handle:close()
    return result
  end
end

return M
