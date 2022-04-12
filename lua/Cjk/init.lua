-- Init.lua
local M = {}
-- Importing Options first

M.opt = require("Cjk.options")


-- reset options
M.reload = function (userOption)
  M.opt.set(userOption)
  M.cjk = nil
  M.cjk = require("Cjk.cjk").new(M.opt.IME_CJK,M.opt.IME_ENG,M.opt.convertKey)
end

vim.cmd [[
  augroup cjkToggle
    autocmd!
    autocmd InsertLeave * call cjk:InputToNormal()
    autocmd InsertEnter * call cjk:NormalToInput()
  augroup end
]]

return M
