set confirm " confirm quit/new file with dialog instead of refusing
set noshelltemp " Use pipes instead of shell temporaries where possible
set expandtab softtabstop=4 shiftwidth=4 " Set tabs to 4 spaces
set formatoptions=tro/qnj " Automatic formatting options; see :help fo-table
                          " we can safely use 't' as all code ftplugins swap
                          " that for 'c' automatically
set guioptions=emgrL " Graphical mode options; see :help guioptions
set ignorecase " Ignore case when searching
set smartcase " Ignore 'ignorecase' when searching with uppercase characters
set listchars=tab:↹·,trail:␢,extends:⇉,precedes:⇇,nbsp:␣ " Characters for :list
let &showbreak='↳ ' " String to show for wrapped lines
set undofile " Save undolist to disk and reload it on BufRead

if has("win32") " Windows Settings
    set guifont=Cascadia_Code:h9:qCLEARTYPE " Windows GUI font
endif

" Custom digraphs
dig o^ 8227 " U+2023 ‣ TRIANGULAR BULLET
dig ?! 8253 " U+204d ‽ INTERROBANG
dig *: 8258 " U+2042 ⁂ ASTERISM
dig h- 8463 " U+210F ℏ PLANCK CONSTANT OVER TWO PI
dig @> 8636 " U+21BB ↻ CLOCKWISE OPEN CIRCLE ARROW

" Plugin options
let g:awk_is_gawk = 1
let g:changelog_username = 'Emma Welker <code@nuew.net>'
let g:rst_style = 1
let g:rustfmt_autosave = 1
let g:sql_type_default = 'postgresql'

" load lsp configuration and lsp_signature
lua require 'lspconf'
lua require'lsp_signature'.setup {}
