
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
vim.g.IME_CJK="korean"
vim.g.IME_ENG="xkb:us::eng"
vim.g.convertKey=false

-- local defaultOptions={IME_CJK = "korean",IME_ENG = "xkb:us::eng",convertKey =false}

--TODO global varliable for OS, convert flag etc

function M.setup()
  M.cjk = require("cjk.cjkfunc")
  -- require("cjk.options").set()

  -- if M.cjk.getOS()=="Linux"then
  --   print("linux")
  --   require("linux").set()
  -- end if M.cjk.getOS()=="Darwin"then
  --   require("macos").set()
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
    M.cjk.NormalToInput()
  end,
  desc = "NormalToInput",
})
-- reset options
function M.reset()
  M.cjk = nil
  M.setup()
  vim.g.inputInCjk=false
end

return M

