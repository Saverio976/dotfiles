" https://www.reddit.com/r/vim/comments/wlelmg/comment/ijtkavg/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

if exists("b:current_syntax")
  finish
endif

syn match csvField1 /[^,]*,\?/ display           nextgroup=csvField2
syn match csvField2 /[^,]*,\?/ display contained nextgroup=csvField3
syn match csvField3 /[^,]*,\?/ display contained nextgroup=csvField4
syn match csvField4 /[^,]*,\?/ display contained nextgroup=csvField5
syn match csvField5 /[^,]*,\?/ display contained nextgroup=csvField6
syn match csvField6 /[^,]*,\?/ display contained nextgroup=csvField7
syn match csvField7 /[^,]*,\?/ display contained

" group have been edited
hi def link csvField1 Normal
hi def link csvField2 Character
hi def link csvField3 Number
hi def link csvField4 Boolean
hi def link csvField5 Statement
hi def link csvField6 Error
hi def link csvField7 Type

let b:current_syntax = "csv"
