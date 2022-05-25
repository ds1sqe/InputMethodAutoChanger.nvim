# InputMethodAutoChanger.nvim
## Automatically Change Input Method in neovim
If you use a Non-English Language while in Input Mode, The input language is automatically changed to English when you leave Input Mode

And When you return to Input Mode, the Input Langauge revert to the Original Non-English Language

Currently we can use this on Linux-Ibus and Mac OS
Windows support is currently work-on-progress

you can use this plugin on your main config,

<code>
  use 'ds1sqe/InputMethodAutoChanger.nvim' </code>
  
<code>require('imac').setup("Target Language Input Method","Eng Input Method","Debug option(true/false) ") </code>

[![Video Label](http://img.youtube.com/vi/7kj8mwXaZf0/0.jpg)](https://youtu.be/7kj8mwXaZf0?t=0s)
