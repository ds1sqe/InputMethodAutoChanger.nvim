
--  ██████╗     ██╗██╗  ██╗   ██╗     ██╗   ██╗ █████╗
-- ██╔════╝     ██║██║ ██╔╝   ██║     ██║   ██║██╔══██╗
-- ██║          ██║█████╔╝    ██║     ██║   ██║███████║
-- ██║     ██   ██║██╔═██╗    ██║     ██║   ██║██╔══██║
-- ╚██████╗╚█████╔╝██║  ██╗██╗███████╗╚██████╔╝██║  ██║
--  ╚═════╝ ╚════╝ ╚═╝  ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
-- For CJK user who want to autoconvert between ENG and CJK
-- @auther ds1sqe@mensakorea.org


local M = {}
vim.g.inputInCjk=false


--TODO global varliable for OS, convert flag etc

-- Importing Options first
M.opt = require("cjk.options")

function M.setup(userOption)
  M.opt.set(userOption)
  M.cjk = require("cjk.cjkfunc").new(M.opt.IME_CJK,M.opt.IME_ENG,M.opt.convertKey)

  if M:getOS()=="Linux"then
    require("linux").set()
  end if M:getOS()=="Darwin"then
    require("macos").set()
  end

local autoToggleCjk= vim.api.nvim_create_augroup("AutoggleCjk", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  group = autoToggleCjk,
  pattern = "*",
  callback = function()
    M.cjk.InputToNormal()
  end,
  desc = "InputToNormal",
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = autoToggleCjk,
  pattern = "*",
  callback = function()
    M.cjk.InputToNormal()
  end,
  desc = "NormalToInput",
})
end

-- reset options
function M.reset(userOption)
  M.cjk = nil
  M.setup(userOption)
  vim.g.inputInCjk=false
end

return M
