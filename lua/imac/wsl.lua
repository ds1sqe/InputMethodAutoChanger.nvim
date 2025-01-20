--script for WSL linux

local M = {
  im_select_path = ""
}

function M.setup(config)
  M.config = config
  M.im_select_path = M.config.imSelectPath
  if M.im_select_path == "" then
    M.im_select_path = vim.fn.stdpath("data") .. "/lazy/InputMethodAutoChanger.nvim/im_select/im-select.exe"
    if M.config.debug then
      print("IMAC> im_select_path(wsl): " .. M.im_select_path)
    end
  end
end

function M.set_lang(inputMethoad)
  os.execute(M.im_select_path .. " " .. inputMethoad)
end

function M.get_language()
  local handle = io.popen(M.im_select_path)
  if handle ~= nil then
    local result = string.gsub(handle:read("*a"), "[\n\r]", "")
    handle:close()
    if M.config.debug then
      print("IMAC> get_language(wsl): " .. result)
    end
    return result
  else
  end
end

function M.check_mode()
  -- return M.get_language() == M.config.wsl.IME_Target
  return true -- return only true because has inner state
end

function M.to_eng()
  M.set_lang(M.config.wsl.IME_ENG)
end

function M.to_target()
  M.set_lang(M.config.wsl.IME_Target)
end

return M
