filetype plugin indent on

call plug#begin('~/.vim/plugged')
" color and theme
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'w0ng/vim-hybrid'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'

Plug 'skywind3000/asyncrun.vim'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'

Plug 'suan/vim-instant-markdown'

" C++ highlight
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Shougo/echodoc.vim'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
Plug 'Valloric/YouCompleteMe'
call plug#end()

" leader 
let mapleader=','
let g:mapleader=','
noremap \ ,

" 使用 leader+w 直接保存
inoremap <leader>w <Esc>:w<cr>
noremap <leader>w :w<cr>

set background=dark
colorscheme molokai
" :colorscheme  slate
set t_Co=256

" <C-n> 弹出的推荐选项颜色
highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" air-line config
" Always show status bar.
set laststatus=2
"这个是安装字体后 必须设置此项" 
let g:airline_powerline_fonts = 1   
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
"set guifont=Consolas\ for\ Powerline\ FixedD:h11
" airline status bar theme
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#formatter = 'unique_tail'
"打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" tab line separator
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
"let g:airline#extensions#tabline#left_sep = '⮁'
"let g:airline#extensions#tabline#left_alt_sep = '⮀'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.paste = 'ρ'

" old vim-powerline symbols
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
"let g:airline_symbols.linenr = '⭡'

"插件， startify
let g:startify_change_to_dir = 0

" AsyncRun
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 编译单个文件。
nnoremap <silent> <F9> :AsyncRun clang++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" 运行编译之后的当前文件
" 用双引号引起来避免文件名包含空格，“-cwd=$(VIM_FILEDIR)”
" 的意思时在文件文件的所在目录运行可执行，后面可执行使用了全路径，避免 linux
" 下面当前路径加 “./” 而 windows 不需要的跨平台问题。
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr><C-w>j<C-w>_<cr>

" nerdtree
nmap <leader>v :NERDTreeFind<CR>
nmap <leader>g :NERDTreeToggle<CR>
let g:NERDTreeSize=25
"修改树的显示图标
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

    " Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ctags configuration
set tags=./.tags;,.tags
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" LeaderF configure
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <c-n> :LeaderfMru<cr>
noremap <m-p> :LeaderfFunction!<cr>
noremap <m-n> :LeaderfBuffer<cr>
noremap <m-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" ale 配置
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'

" tagbar
nmap <Leader>t :TagbarToggle<CR>

" 停止显示补全列表(防止列表影响视野), 可以按<C-Space>重新弹出
let g:ycm_key_list_stop_completion = ['<C-y>']
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
" 关闭函数原型预览窗口
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-space>'
set completeopt=menu,menuone
"let g:ycm_semantic_triggers =  {
			"\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			"\ 'cs,lua,javascript': ['re!\w{2}'],
			"\ }
let g:ycm_filetype_whitelist = { 
			\ "c":1,
			\ "cpp":1, 
			\ "objc":1,
			\ "sh":1,
			\ "zsh":1,
			\ "zimbu":1,
			\ }

"设置 ALT 正确映射
set ttimeout ttimeoutlen=50
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc

call Terminal_MetaMode(0)

set vb t_vb=
set expandtab
set nu
set shiftwidth=4
set tabstop=4
set ai
set syntax=on
set hlsearch

set pastetoggle=<F2>

" ctrl + h/j/k/l to switch window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" 设置查找的时候居中
noremap <Leader>n nzz
noremap <Leader>N nzz

inoremap jj <Esc>

