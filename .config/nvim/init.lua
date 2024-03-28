-- General Configuration
vim.opt.confirm = true -- confirm quit/new file with dialog instead of refusing
vim.opt.shelltemp = false -- Use pipes instead of shell temporaries where possible
vim.opt.formatoptions = 'tro/qnj' -- Automatic formatting options; see :help fo-table
                                  -- we can safely use 't' as all code ftplugins swap
                                  -- that for 'c' automatically
vim.opt.guioptions = 'emgrL' -- Graphical mode options; see :help guioptions
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Ignore 'ignorecase' when searching with uppercase characters
vim.opt.listchars = 'tab:↹·,trail:␢,extends:⇉,precedes:⇇,nbsp:␣' -- Characters for :list
vim.opt.showbreak = '↳ ' -- String to show for wrapped lines
vim.opt.undofile = true

-- Set tabs to 4 spaces
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Custom Digraphs; AFAICT there's no native lua interface for this?
vim.cmd('digraphs o^ 8227') -- U+2023 ‣ TRIANGULAR BULLET
vim.cmd('digraphs ?! 8253') -- U+204d ‽ INTERROBANG
vim.cmd('digraphs *: 8258') -- U+2042 ⁂ ASTERISM
vim.cmd('digraphs h- 8463') -- U+210F ℏ PLANCK CONSTANT OVER TWO PI
vim.cmd('digraphs @> 8636') -- U+21BB ↻ CLOCKWISE OPEN CIRCLE ARROW

-- Plugin Options
vim.g.awk_is_gawk = 1
vim.g.changelog_username = 'Emma Welker <code@nuew.net>'
vim.g.rst_style = 1
vim.g.rustfmt_autosave = 1
vim.g.sql_type_default = 'postgresql'

-- Delete undofiles older than one week
os.execute('/usr/bin/find ' .. vim.opt.undodir:get()[1] .. ' -mtime +7 -delete')

require 'lsp' -- configure LSP and nvim-cmp
