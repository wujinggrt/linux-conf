filetype plugin indent on

call plug#begin('~/.vim/plugged')
" color and theme
" themes ============================================
Plug 'ajmwagar/vim-deus'
Plug 'crusoexia/vim-monokai'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized' 
Plug 'w0ng/vim-hybrid'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'Yggdroot/indentLine'
Plug 'tomasiser/vim-code-dark'
Plug 'luochen1990/rainbow'

Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

Plug 'skywind3000/asyncrun.vim'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'

" underline the word that cursor placed
Plug 'itchyny/vim-cursorword'
" highlight the cursor 
Plug 'lfv89/vim-interestingwords' 
"
" go
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" C++ highlight
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar'
Plug 'Valloric/YouCompleteMe'

" show func prototype when calling
Plug 'Shougo/echodoc.vim'

Plug 'rhysd/vim-clang-format'

" completion
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-smooth-scroll'
Plug 'junegunn/vim-slash'
call plug#end()

" check undo file if not exist
function! CreateDirectoryIfNotExist(directory)
  if !isdirectory(a:directory)
    silent! call mkdir(a:directory, 'p')
  endif
endfunction

call CreateDirectoryIfNotExist($HOME . '/.vim/undodir')
" Maintain undo history between sessions
set undofile
" if not exist, mkdir it.
set undodir=~/.vim/undodir

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
"let g:airline_theme='bubblegum'
"let g:airline_theme='base16'
let g:airline_theme='solarized'
"let g:airline_theme='lucius'
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
nnoremap <silent> <F9> :AsyncRun clang++ -std=c++17 -Wall "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" -g <cr>
" 运行编译之后的当前文件
" 用双引号引起来避免文件名包含空格，“-cwd=$(VIM_FILEDIR)”
" 的意思时在文件文件的所在目录运行可执行，后面可执行使用了全路径，避免 linux
" 下面当前路径加 “./” 而 windows 不需要的跨平台问题。
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <silent> <F6> :AsyncRun clang++ -Wall "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr><C-w>j<C-w>_<cr>

" nerdtree
nnoremap <leader>v :NERDTreeFind<CR>
nnoremap <leader>g :NERDTreeToggle<CR>
let g:NERDTreeSize=25
"修改树的显示图标
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ctags configuration
" 前半部分 “./.tags; ”代表在文件的所在目录下（不是 “:pwd”返回的 Vim 当前目录）查找名字为 “.tags”的符号文件，后面一个分号代表查找不到的话向上递归到父目录，直到找到 .tags 文件或者递归到了根目录还没找到，这样对于复杂工程很友好，源代码都是分布在不同子目录中，而只需要在项目顶层目录放一个 .tags文件即可；逗号分隔的后半部分 .tags 是指同时在 Vim 的当前目录（“:pwd”命令返回的目录，可以用 :cd ..命令改变）下面查找 .tags 文件

"作者：韦易笑
"链接：https://www.zhihu.com/question/47691414/answer/373700711
"
"如果有需要重新生成，可在当前目录下# 查找 C Cpp H ：
"$find . -type f \( -name "*.[c|h]" -or -name "*.cpp" \) | xargs ctags
"naming it as .tags
"C-[ and C-t jump front and back
"
"but fuzzl is useful more, leaderFTags, alt-m
"
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

set fenc=

" c++ filetype cpp
let g:ale_linters = {
      \'c': ['clang'], 
      \'cpp': ['clang'],
      \'python':[],
      \'rust':['cargo'],
      \}
let g:ale_completion_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
"let g:ale_echo_msg_format = '[%linter%] %code: %%s'
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
" `'normal'`            - Check buffers only on |TextChanged|.
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++17'
let g:ale_c_clang_options = '-Wall -Wextra -O2 -std=c99'
let g:ale_cpp_clang_options = '-Wall -Wextra -O2 -std=c++17'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

" echodoc.vim
let g:echodoc#type = "echo" " Default value

hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! clear SignColumn
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta
let g:ale_sign_error = '✗'
"let g:ale_sign_error = "\u2717"
let g:ale_sign_warning = '⚡'
"let g:ale_sign_warning = "\ue009"
"设置状态栏显示的内容
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{ALEGetStatusLine()}
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
"nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
"nmap <Leader>d :ALEDetail<CR>

let g:clang_format#code_style="google"

" tagbar
noremap <Leader>t :TagbarToggle<CR>

" 停止显示补全列表(防止列表影响视野), 可以按<C-Space>重新弹出
let g:ycm_key_list_stop_completion = ['<C-y>']
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_clangd_args = ['-log=verbose', '-pretty']

"disable ycm 语法检查
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
" no echo YcmDiags
let g:ycm_echo_current_diagnostic = 0
" 可以设置syntastic提示符号为别的符号，确定关闭syntastic成功。区分syntastic和Ale的提示。
"ycmd setting
let g:ycm_error_symbol = 'K'
let g:ycm_warning_symbol = 'O'

" 关闭函数原型预览窗口
let g:ycm_add_preview_to_completeopt = 0
"关闭语法提示
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
" 输入第二个关键字就开始补全
let g:ycm_min_num_identifier_candidate_chars = 2
" 收录中文也能够不全
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
" 主动补全
let g:ycm_key_invoke_completion = '<c-space>'
set completeopt=menu,menuone
"let g:ycm_semantic_triggers =  {
"\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
"\ 'cs,lua,javascript': ['re!\w{2}'],
"\ }
" 只对这些文件分析，否则打开其他文件很慢
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

" Repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

noremap <plug>(slash-after) zz

" To use echodoc, you must increase 'cmdheight' value.
set cmdheight=2
let g:echodoc_enable_at_startup = 1

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

" 加载自定义配置
for f in split(glob('~/.vimconf/*.vim'), '\n')
  exe 'source' f
endfor

