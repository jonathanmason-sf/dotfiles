set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "jemsimple"

hi Comment ctermfg=DarkBlue
hi Constant ctermfg=DarkRed
hi Special ctermfg=DarkGreen
hi SpecialKey ctermfg=LightGrey
hi Identifier ctermfg=Black
hi Statement ctermfg=Black
hi PreProc ctermfg=DarkMagenta
hi Type ctermfg=DarkMagenta
hi Visual ctermfg=Yellow ctermbg=Red
hi Search ctermfg=Black ctermbg=Cyan
hi Tag ctermfg=DarkGreen
hi Error ctermfg=White ctermbg=Red
hi Todo ctermfg=Black ctermbg=Yellow
hi StatusLine ctermfg=Yellow ctermbg=DarkGray

hi! link MoreMsg Comment
hi! link ErrorMsg Visual
hi! link WarningMsg ErrorMsg
hi! link Question Comment
hi link String	Constant
hi link Character	Constant
hi link Number	Constant
hi link Boolean	Constant
hi link Float		Number
hi link Function	Identifier
hi link Conditional	Statement
hi link Repeat	Statement
hi link Label		Statement
hi link Operator	Statement
hi link Keyword	Statement
hi link Exception	Statement
hi link Include	PreProc
hi link Define	PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special
