" Title:        Cjk Vim
" Description:  Automatically Convert between Cjk languge and Eng
" Maintainer:   ds1sqe@mensakorea.org

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_cjkvim")
    finish
endif
let g:loaded_cjkvim= 1

lua require("cjk").setup()
