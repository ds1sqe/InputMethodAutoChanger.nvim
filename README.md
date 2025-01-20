# InputMethodAutoChanger.nvim
## Automatically Change Input Method in neovim
If you use a Non-English Language while in Input Mode, The input language is automatically changed to English when you leave Input Mode

And When you return to Input Mode, the Input Langauge revert to the Original Non-English Language

You can use this plugin on your main config as below,

To import my plugin with vimplug or etc,

``` lua
-- packer-like
use 'ds1sqe/InputMethodAutoChanger.nvim' 
-- lazy-like
{
    "ds1sqe/InputMethodAutoChanger.nvim",
    event = "BufReadPost",
    config = function()
      require("imac").setup(
        {
          debug = true,
        }
      )
    end,
}
```

And setup with,
``` lua
require("imac").setup(
  {
     debug = false,
  }
)
```

Default configuration 
``` lua
{
  macos = { -- Config for Macos
    IME_ENG = "com.apple.keylayout.ABC",
    IME_Target = "com.apple.inputmethod.Korean.2SetKorean",
  },
  linux = {
    ibus = { -- Config for Linux-Ibus
      IME_ENG = "xkb:us::eng",
      IME_Target = "hangul",
    },
    fcitx = { -- Config for Linux-fcitx5
      IME_ENG = "keyboard-us",
      IME_Target = "hangul",
    },
  },
  wsl = { -- Config for window wsl-linux
    IME_ENG = "eng_wsl",
    IME_Target = "tgt_wsl",
  },
  windows = { -- Config for windows
    IME_ENG = "eng_win",
    IME_Target = "tgt_win",
  },
  debug = false,
  imSelectPath = "",
},
```

[![Video Label](http://img.youtube.com/vi/7kj8mwXaZf0/0.jpg)](https://youtu.be/7kj8mwXaZf0?t=0s)
