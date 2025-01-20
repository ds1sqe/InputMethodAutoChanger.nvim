-- Options for Plugin

local M = {
  default = {
    macos = {
      IME_ENG = "com.apple.keylayout.ABC",
      IME_Target = "com.apple.inputmethod.Korean.2SetKorean",
    },
    linux = {
      ibus = {
        IME_ENG = "xkb:us::eng",
        IME_Target = "hangul",
      },
      fcitx = {
        IME_ENG = "keyboard-us",
        IME_Target = "hangul",
      },
    },
    wsl = {
      IME_ENG = "eng_wsl",
      IME_Target = "tgt_wsl",
    },
    windows = {
      IME_ENG = "eng_win",
      IME_Target = "tgt_win",
    },
    debug = false,
    imSelectPath = "",
  },
}

function M.set(config, root)
  local conf = M.default
  local conf = vim.tbl_deep_extend("force", conf, config)

  local handle = io.popen("grep -i Microsoft /proc/version")
  if handle ~= nil then
    local result = string.gsub(handle:read("*a"), "[\n\r]", "")
    handle:close()
    if result ~= "" then
      root.state.is_wsl = true
    else
      local handle = io.popen("uname")
      if handle ~= nil then
        local result = string.gsub(handle:read("*a"), "[\n\r]", "")
        handle:close()
        if result == "Linux" then
          root.state.is_linux = true
        elseif result == "Darwin" then
          root.state.is_macos = true
        else
          root.state.is_windows = true
        end
        root.state.config = conf
      end
    end
  end

  root.state.DEBUG_MODE = conf.debug
end

return M
