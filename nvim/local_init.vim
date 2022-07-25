let g:python3_host_prog = '/usr/local/bin/python3'
"custom mappings
set relativenumber
autocmd FileType python setlocal noet ci pi sts=0 sw=4 ts=4

"colorscheme
colorscheme nightfox

"plugin configs
let g:conoline_auto_enable = 1
let g:conoline_use_colorscheme_default_normal=1
let g:hardtime_default_on = 1

let g:better_escape_shortcut = ['jk', 'jj', 'kj'] 

lua require("toggleterm").setup{}
lua << EOF
function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end
EOF
"" if you only want these mappings for toggle term use term://*toggleterm#* instead
lua vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

let g:mkdp_filetypes = ['markdown', 'plantuml']
let g:mkdp_command_for_global = 1
let g:mkdp_auto_close = 0

lua << EOF
require("lspconfig").pylsp.setup{}
EOF

lua << EOF
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 10000
    }
)
EOF

set completeopt-=preview

" use omni completion provided by lsp
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
"mappings
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files theme=get_dropdown<cr>
nnoremap <leader>fg <cmd>Telescope live_grep theme=get_dropdown<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <silent> <leader>sh :ToggleTerm size=40 direction=vertical<cr> 
nnoremap <silent> <leader>csh :ToggleTerm<cr> 

nnoremap <silent> <leader>evc :e ~/.config/nvim/local_init.vim<cr>
nnoremap <silent> <leader>evp :e ~/.config/nvim/local_bundles.vim<cr>o
augroup python
    autocmd!
"   autocmd FileType python nnoremap <silent> gd    <cmd>lua vim.lsp.buf.implementation()<CR>
    autocmd FileType python nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
    autocmd FileType python nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    autocmd FileType python nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
    autocmd FileType python nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    autocmd FileType python nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    autocmd FileType python nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    autocmd FileType python nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    autocmd FileType python nnoremap <silent> gW    <cmd>lua videclarationm.lsp.buf.workspace_symbol()<CR>
augroup END
