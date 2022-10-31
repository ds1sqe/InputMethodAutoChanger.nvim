-- Scripts for macos

local M = {}

function M.set_lang(inputMethoad)
  if inputMethoad ~= "" then
    os.execute("/usr/local/bin/im-select " .. inputMethoad)
    if vim.g.imac_DEBUGMODE == true then
      print("Imac.macos(set) : im-select " .. inputMethoad)
    end
  end
end

function M.get_language()
  local handle = io.popen("/usr/local/bin/im-select")
  if handle ~= nil then

    local result = string.gsub(handle:read("*a"), "[\n\r]", "")
    handle:close()
    if vim.g.imac_DEBUGMODE == true then
      print("Imac.macos(get) : /usr/local/bin/im-select" .. result)
    end
    return result
  end
end

function M.set()
  if vim.g.IME_ENG == "" then
    vim.g.IME_ENG = "com.apple.keylayout.ABC"
  end
  if vim.g.IME_Target == "" then
    vim.g.IME_Target = "com.apple.inputmethod.Korean.2SetKorean"

  end
  if os.execute("which im-select") == 1 then
    os.execute("brew tap daipeihust/tap && brew install im-select")
  end

end

return M
