-- ██╗ ███╗   ███╗  █████╗   ██████╗     ██╗     ██╗   ██╗  █████╗
-- ██║ ████╗ ████║ ██╔══██╗ ██╔════╝     ██║     ██║   ██║ ██╔══██╗
-- ██║ ██╔████╔██║ ███████║ ██║          ██║     ██║   ██║ ███████║
-- ██║ ██║╚██╔╝██║ ██╔══██║ ██║          ██║     ██║   ██║ ██╔══██║
-- ██║ ██║ ╚═╝ ██║ ██║  ██║ ╚██████╗ ██╗ ███████╗╚██████╔╝ ██║  ██║
-- ╚═╝ ╚═╝     ╚═╝ ╚═╝  ╚═╝  ╚═════╝ ╚═╝ ╚══════╝ ╚═════╝  ╚═╝  ╚═╝
-- InputMethodAutoChanger
-- For non English user who want to change Automatically between English and None English
-- @auther ds1sqe@mensakorea.org

local M = {}


--TODO global varliable for OS, convert flag etc

require("notify")("IMAC init")

vim.g.inputInTarget=false
vim.g.imac_DEBUGMODE=false
vim.g.imac_OS= ""
vim.g.IME_Target= ""
vim.g.IME_ENG= ""
vim.g.InputColor_Eng = ""
vim.g.InputColor_Target = ""

-- Setup function. you can use this at your main config , like require('imac').setup("hangul","xkb:us::eng",false)
-- @param ime_Target => target inputMethod, Non English ex) "hangul"
-- @param ime_eng => Eng inputMethod, English ex) "xkb:us::eng"
-- @param debug_mode => debug mode , True or False ex) "true"
function M.setup(ime_target,ime_eng,debug_mode)

  require("imac.options").set(ime_target,ime_eng,debug_mode)

  if vim.g.imac_DEBUGMODE==true then
    require("notify")("imac: setup called")
  end
  M.imac = require("imac.func")
end

local inputMethodAutoChanger= vim.api.nvim_create_augroup("InputMethodAutoChanger", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  group = inputMethodAutoChanger,
  pattern = "*",
  callback = function()
    M.imac.InputToNormal()
  end,
  desc = "InputToNormal",
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = inputMethodAutoChanger,
  pattern = "*",
  callback = function()
    M.imac.NormalToInput()
  end,
  desc = "NormalToInput",
})
-- unload options
function M.unload()
  M.imac = nil
  vim.g.inputInTarget=false
end

return M
