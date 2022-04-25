# InputMethodAutoChanger.nvim
## Automatticaly Change Input Method in neovim
if you use Non-English Langauge in Input Mode, automatically change to english when you leave InputMode

And you come back to Input Mode, change to Non-English Langauge what you used in Input mode

currently only available on linux - ibus only


you can use this plugin at your main config,

<code>
  use 'ds1sqe/InputMethodAutoChanger.nvim' </code>
  
<code>require('imac').setup("hangul","xkb:us::eng",false) </code>
