-- ██╗ ███╗   ███╗  █████╗   ██████╗     ██╗     ██╗   ██╗  █████╗
-- ██║ ████╗ ████║ ██╔══██╗ ██╔════╝     ██║     ██║   ██║ ██╔══██╗
-- ██║ ██╔████╔██║ ███████║ ██║          ██║     ██║   ██║ ███████║
-- ██║ ██║╚██╔╝██║ ██╔══██║ ██║          ██║     ██║   ██║ ██╔══██║
-- ██║ ██║ ╚═╝ ██║ ██║  ██║ ╚██████╗ ██╗ ███████╗╚██████╔╝ ██║  ██║
-- ╚═╝ ╚═╝     ╚═╝ ╚═╝  ╚═╝  ╚═════╝ ╚═╝ ╚══════╝ ╚═════╝  ╚═╝  ╚═╝
-- InputMethodAutoChanger
-- For non English user who want to change Automatically between English and Non-English
-- @auther ds1sqe@mensakorea.org

local M = {
  DEBUG_MODE = false,
  state = {
    input_in_target = false,
    is_wsl = false,
    is_linux = false,
    is_macos = false,
    is_windows = false,
    is_remote = false,
  }
}

-- Setup function. you can use this at your main config , like require('imac').setup({"OPTIONS"})
function M.setup(config)
  require("imac.options").set(config, M)

  M.load()
  if M.DEBUG_MODE then
    print("IMAC> loaded config:" .. M.inspect(M))
  end

  if M.state.is_remote then
    if M.DEBUG_MODE then
      print("IMAC> disabled due to is remote")
      return
    end
  end

  local inputMethodAutoChanger = vim.api.nvim_create_augroup("InputMethodAutoChanger", { clear = true })

  vim.api.nvim_create_autocmd("InsertLeave", {
    group = inputMethodAutoChanger,
    pattern = "*",
    callback = function()
      M.InputToNormal()
    end,
    desc = "InputToNormal",
  })

  vim.api.nvim_create_autocmd("InsertEnter", {
    group = inputMethodAutoChanger,
    pattern = "*",
    callback = function()
      M.NormalToInput()
    end,
    desc = "NormalToInput",
  })
end

-- unload options
function M.unload()
  M.func = nil
end

function M.load()
  if M.state.is_wsl == true then
    M.func = require("imac.wsl")
  elseif M.state.is_linux == true then
    M.func = require("imac.linux")
  elseif M.state.is_macos == true then
    M.func = require("imac.macos")
  elseif M.state.is_windows == true then
    M.func = require("imac.windows")
  end
  M.func.setup(M.state.config)
end

--Check if input in imac, if then, Raise Flag
--and convert IME to Eng
function M.InputToNormal()
  M.state.input_in_target = M.func.check_mode()
  if M.state.input_in_target == true then
    M.func.to_eng()
    if M.DEBUG_MODE == true then
      print("IMAC> changing ime to english")
    end
  end
end

-- Automatically convert to imac if you exited inputmod with imac
function M.NormalToInput()
  if M.state.input_in_target == true then
    M.func.to_target()
    if M.DEBUG_MODE == true then
      print("IMAC> changing ime to target")
    end
  end
end

function M.inspect(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. M.inspect(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

return M
