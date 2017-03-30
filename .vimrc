execute pathogen#infect()
filetype plugin indent on                   " required
filetype on                                 " required

" ----------------------------------------- "
"   Settings                                "
" ----------------------------------------- "
set autoindent                              " Indentation aware
set autoread                                " Refresh external changes immediately
set colorcolumn=80                          " Draw a column at this position
set cursorline                              " Draw horizontal line on cursor's position
set dictionary+=/usr/share/dict/words       " Dictionary sources
set encoding=utf-8                          " Character encoding
set fileencoding=utf-8                      " File encoding
set nocompatible                            " Don't fallback to vi compatibility
set nrformats-=octal                        " Decimal number format
set number                                  " Diplay line numbers
set smarttab                                " Auto indent to the next tabstop
set relativenumber                          " Display line numbers from cursor's position
set selection=exclusive                     " Selection don't include character under cursor
set shiftwidth=4                            " Shift width in columns
set showcmd                                 " Show commands in window's footer
set tabstop=4                               " Tab width in columns
set textwidth=79                            " Wrap text longer than this size on a new line
set wrapmargin=0                            " Number of chars from the right before wrapping
set backupdir=~/.vim/recovery/backup//      " Path for backups
set directory=~/.vim/recovery/swap//        " Path for swap files
set undodir=~/.vim/recovery/undo//          " Path for undos


" ----------------------------------------- "
"   Syntax highlighing                      "
" ----------------------------------------- "
syntax enable                               " Enable syntax highlighting
let base16colorspace=256                    " Set colorspace
colorscheme molokai                         " Load molokai theme first to get a better background
colorscheme base16-solarized-dark           " Then load solarized theme


" ----------------------------------------- "
"   Autocomands                             "
" ----------------------------------------- "
au BufEnter * set scrolloff=30
au FileType qf wincmd J
au VimLeave * !echo -ne "\033[0m"

" Markdown specifics
au BufNewFile,BufReadPost *.md set filetype=markdown

" Python specifics
au BufNewFile,BufReadPost *.py set filetype=python
au FileType python set iskeyword-=:
au FileType python setl nowrap ts=8 sw=4 sts=4

" Ruby & Crystal specifics
au BufNewFile,BufReadPost *.pp set filetype=puppet
au FileType ruby,crystal setl nowrap sw=2 sts=2
au FileType puppet setl nowrap sw=2 sts=2

" YAML specifics
au FileType yaml setl nowrap sw=2 sts=2


" ----------------------------------------- "
"   Plugins                                 "
" ----------------------------------------- "

" ag
let g:ag_working_path_mode="r"
nmap <Leader><Leader>a :Ag<space>
nmap <Leader>aa :Ag <C-r><C-w><CR>

" ansible
let g:ansible_options = {'ignore_blank_lines': 0}

" airline
let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1

" autoformat
let g:formatter_yapf_style = 'pep8
\ DEDENT_CLOSING_BRACKETS=True
\ COALESCE_BRACKETS=True
\ EACH_DICT_ENTRY_ON_SEPARATE_LINE=True
\ SPLIT_BEFORE_NAMED_ASSIGNS=True'

au BufWrite *.py :Autoformat

" crytal-vim
let g:crystal_auto_format=1

" delimitmate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 0

" easyalign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" easygrep
let g:EasyGrepRecursive=1

" emmet
let g:user_emmet_leader_key='<C-C>'

" git-gutter
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" go-vim
let g:go_auto_type_info = 0
let g:go_fmt_command = "goimports"
let g:go_highlight_build_constraints = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_trailing_whitespace_error = 0
au FileType go nmap gi <Plug>(go-install)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>l :GoLint<CR>
au FileType go nmap <Leader>q :GoImport<space>
au FileType go nmap <Leader>f :GoImpl<space>
au FileType go nmap <Leader>ff <Plug>(go-implements)
au FileType go vmap <Leader>r :GoAddTags<space>
au FileType go vmap <Leader>p :GoPlay<CR>
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>s <Plug>(go-install)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap <Leader>v <Plug>(go-vet)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>gs <Plug>(go-doc-split)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" grammarous
let g:grammarous#default_comments_only_filetypes = {'*': 1, 'help': 0, 'markdown': 0}
nmap <Leader>g  :GrammarousCheck<CR>
nmap <Leader>ga <Plug>(grammarous-fixall)
nmap <Leader>gf <Plug>(grammarous-fixit)
nmap <Leader>gr <Plug>(grammarous-remove-error)
nmap <Leader>gd <Plug>(grammarous-disable-rule)
nmap !          <Plug>(grammarous-move-to-next-error)
nmap §          <Plug>(grammarous-move-to-previous-error)

" gundo
nmap <F7> :GundoToggle<CR>

" instant-markdown
let g:instant_markdown_autostart = 0

" licenses
let g:licenses_copyright_holders_name = 'Xavier Lucas'

" nerdtree
nmap <F6> :NERDTreeFind<CR>

" nerdtree-tabs
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_focus_on_files = 1

" previm
let g:previm_open_cmd = 'firefox'

" ruby
au FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
au FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
au FileType ruby,eruby let g:rubycomplete_rails = 1

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:go_list_type='quickfix'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['go', 'gofmt', 'golint', 'govet']
let g:syntastic_ignore_files = ['\.s$']

" tablemode
let g:table_mode_corner_corner="+"
let g:table_mode_header_fillchar="="

" tabularize
nmap <F10> :Tabularize /,\zs<CR>
vmap <F10> :Tabularize /,\zs<CR>
nmap <F12> :Tabularize / \zs<CR>
vmap <F12> :Tabularize / \zs<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>
au VimEnter * nested :TagbarOpen
au BufEnter * nested :call tagbar#autoopen(0)

" ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

" youcompleteme
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1


" ----------------------------------------- "
"   Base shortcuts                          "
" ----------------------------------------- "

" Go to next error
nmap , :lnext<CR>

" Go to previous error
nmap ? :lprevious<CR>

" Create a new tab
nmap <F2> :tabnew<CR>

" Close current tab
nmap <F9> :tabclose<CR>

" Go to previous tab
nmap <C-Down> :tabprevious<CR>

" Go to next tab
nmap <C-Up> :tabnext<CR>

" Highlight search results
nmap <F4> :set hlsearch<CR>

" Unhighlight search results
nmap <F5> :nohlsearch<CR>

" Start a gobal replace of the word under the cursor
nmap <Leader><Leader>s :%s/<C-r><C-w>/

" Change window layout to vertical split
nmap <Leader><Leader>v :windo wincmd H<CR>

" Change window layout to horizontal split
nmap <Leader><Leader>h :windo wincmd K<CR>
