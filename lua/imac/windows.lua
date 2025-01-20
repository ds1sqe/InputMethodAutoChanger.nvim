--script for windows

local M = {
  im_select_path = ""
}

function M.setup(config)
  M.config = config
  M.im_select_path = config.imSelectPath
  if M.im_select_path == "" then
    M.im_select_path = vim.fn.stdpath("data") .. "\\InputMethodAutoChanger.nvim\\im_select\\im-select.exe"
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
    return result
  else
  end
end

function M.check_mode()
  return M.get_language() == M.config.windows.IME_Target
end

function M.to_eng()
  M.set_lang(M.config.windows.IME_ENG)
end

function M.to_target()
  M.set_lang(M.config.windows.IME_Target)
end

return M
