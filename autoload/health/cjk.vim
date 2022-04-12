" Health checker
function! health#cjk#check()
    if !has('nvim-0.5')
        call health#report_warn("please install nvim > 0.5")
    else
        call health#report_ok("nvim 0.5 installed")
    endif
    if !executable('ibus engine')
      call health#report_error("IME is not a ibus installed")
    else
        call health#report_ok("IME is ibus")
    endif
    if !executable('xdotools')
      call health#report_error("xdotool not installed")
    else
        call health#report_ok("xdotools found")
    endif
endfunction
