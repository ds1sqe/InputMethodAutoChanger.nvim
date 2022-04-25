# InputMethodAutoChanger.nvim
## Automatically Change Input Method in neovim
if you use Non-English Language in Input Mode, automatically change to English when you leave Input Mode

And you come back to Input Mode, change to Non-English Language what you used in Input mode

currently only available on linux - ibus only


you can use this plugin at your main config,

<code>
  use 'ds1sqe/InputMethodAutoChanger.nvim' </code>
  
<code>require('imac').setup("Target Language Input Method","Eng Input Method","debug Option(true/false) ") </code>
