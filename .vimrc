filetype plugin indent on

call plug#begin('~/.vim/plugged')
" color and theme
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized' 
Plug 'w0ng/vim-hybrid'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'

Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

Plug 'skywind3000/asyncrun.vim'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

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

" <C-n> 弹出的推荐选项颜色
highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" instant markdown
"Uncomment to override defaults:
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
let g:instant_markdown_open_to_the_world = 1 
let g:instant_markdown_allow_unsafe_content = 1
let g:instant_markdown_allow_external_content = 0
let g:instant_markdown_mathjax = 1

" air-line config
" Always show status bar.
set laststatus=2
"这个是安装字体后 必须设置此项" 
let g:airline_powerline_fonts = 1   
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
"set guifont=Consolas\ for\ Powerline\ FixedD:h11
" airline status bar theme
"let g:airline_theme='powerlineish'
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#formatter = 'unique_tail'
"打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
" tab line separator
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
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.paste = 'ρ'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

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
nnoremap <silent> <F6> :AsyncRun clang++ -Wall "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

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

" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_clangd_args = ['-log=verbose', '-pretty']

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

nnoremap <silent> <Leader>gt  :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>dd  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <silent> <Leader>rf  :YcmCompleter GoToReferences<CR>
nnoremap <silent> <Leader>doc :YcmCompleter GetDoc<CR>

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

function! RemovePairs()
  let l:line = getline(".")
  let l:previous_char = l:line[col(".") - 1]
  if index(["(", "[", "{"], l:previous_char) != -1
    " 选择括号对位置
    let l:original_pos = getpos(".")
    execute "normal %"
    let l:new_pos = getpos(".")

    " 没有配对的即普通情况
    if l:original_pos == l:new_pos
      execute "normal! a\<BS>"
      return
    end
    " let l:line2 = getline(".")
    " 如果是末尾的话，i 不能够直接到那儿
    " 所以需要 append
    " if len(l:line2) == col(".")
    "
    " - 1 是因为换行符站在最后一格位置，即 \r
    " 否则当括号在最后的情况，删除括号及其内容之后，
    " 光标会前进一格，此时应该使用 a 而不是 i。比如：
    "   vec.size() 删除之后 vec.size 光标就会被末尾给挤到了 e 的位置。
    " 一般情况则删除之后光标仍然在左括号的位置，比如：
    "   vec.size(); 在删除之后光标在中括号的那个位置 vec.size[];
    " 当执行完 normal 的命令之后，返回的时候则会相当于 Esc，
    " 从而光标又会前进一格。所以两个 if 就是确定光标在函数结束，
    " 在同一个位置，也就是之前删除的左括号的前一个字符那儿，
    " 然后在函数之外在执行一 a，完成功能。
    if col("$") - 1 == col(".")
      execute "normal! v%xa"
    else
      execute "normal! v%xi"
    end  
  else
    " 无括号的普通情况
    execute "normal! a\<BS>"
  end
endfunction

inoremap <BS> <ESC>:call RemovePairs()<CR>a
inoremap <C-h> <ESC>:call RemovePairs()<CR>a

function! RemoveNextDoubleChar(char)
  let l:line = getline(".")
  let l:next_char = l:line[col(".")] "     
  if a:char == l:next_char
    execute "normal! l"
  else
    execute "normal! i" . a:char . ""
  end
endfunction

" <Esc> 会吧光标前推到刚刚输入的那个字符上
" x 也就是删除，会把后面的文本往这儿缩，
" 或者在末尾的话，就光标前移
inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a

set background=dark
colorscheme molokai
"colorscheme solarized
set t_Co=256

set vb t_vb=
set expandtab
set nu
set shiftwidth=2
set tabstop=2
set ai
set syntax=on
set hlsearch

set pastetoggle=<F8>

" select word
nnoremap <space> viw

" ctrl + h/j/k/l to switch window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" 使用 leader+w 直接保存
inoremap <leader>w <Esc>:w<cr>
inoremap <leader>W <Esc>:wa<cr>
noremap <leader>w :w<cr>
noremap <leader>W :wa<cr>
nnoremap <leader>d dd
inoremap <leader>d <Esc>ddi

" exit
noremap <leader>e :q<cr>
noremap <leader>E :qa!<cr>
noremap <leader>b :bd<cr>
" vertical split
noremap <leader>s :vs<cr>
" reload without save
noremap <leader>r :e!<cr>

inoremap <C-j> <CR>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

noremap j jzz
noremap k kzz
noremap 0 ^
noremap ^ 0
noremap - $
" h shift to left one char
vnoremap - $h
noremap * *zz
noremap # #zz
" 设置查找的时候居中
noremap <Leader>n nzz
noremap <Leader>N nzz
noremap <S-h> b
noremap <S-l> e
noremap <C-o> <C-o>zz
noremap <C-i> <C-i>zz

inoremap jk <Esc>

" 给一个 word 添加双引号
nnoremap <leader>" viw<Esc>a"<Esc>hbi"<Esc>lel

inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<ESC>O
inoremap {<C-j> {<CR>}<ESC>O
inoremap {} {}
inoremap {; {<CR>};<ESC>O

inoremap ( ()<ESC>i
inoremap () ()
inoremap [ []<ESC>i
inoremap [] []
inoremap < <><ESC>i
" inoremap <<SPACE> <<ESC><RIGHT>r<SPACE>a
inoremap <<SPACE> <<SPACE>
inoremap << <<<ESC>a
inoremap <= <=<ESC>a
inoremap <> <><ESC>a

"alt + hjkl 插入模式下移动
inoremap <m-l> <Right>
inoremap <m-h> <Left>
inoremap <m-j> <Down>
inoremap <m-k> <Up>
inoremap <m--> <ESC>A
inoremap <m-0> <ESC>^i

"vim 和终端背景一致：添加下面到 .vimrc
hi Normal ctermfg=252 ctermbg=none
