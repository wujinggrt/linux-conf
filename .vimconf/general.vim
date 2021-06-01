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
  " 最后一列，光标在末尾，回车符那儿
  " 也就是只需要添加一个单独的右括号
  " 这种需求是在不小心删除了括号对的情况下发生的
  " 
  " 注意Esc的副作用，此时光标在之前的前一格，
  " 也就是可能是（，所以就有currentcol等于直接获取
  " col(".")
  let l:current_col = col(".")
  if l:current_col == col("$") - 1
    execute "normal! a" . a:char . ""
    return
  endif
  "     sad(das
  " 在上这种情况添加有括号，会出)(现的请况
  " 所以就需要 a
  let l:next_char = l:line[current_col]
  if a:char == l:next_char
    execute "normal! l"
  else
    execute "normal! a" . a:char . ""
  endif
endfunction

" <Esc> 会吧光标前推到刚刚输入的那个字符上
" x 也就是删除，会把后面的文本往这儿缩，
" 或者在末尾的话，就光标前移
inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a

set background=dark
"colorscheme molokai
"colorscheme one
"colorscheme hybrid
colorscheme gruvbox
set t_Co=256

set vb t_vb=
set expandtab
set nu
set numberwidth=3
"强制侧边符号栏
"auto/yes/no
set signcolumn=auto
set shiftwidth=2
set tabstop=2
set ai
set syntax=on
set hlsearch

" set foldmethod=indent

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

" exit
noremap <leader>e :q<cr>
noremap <leader>E :qa!<cr>
noremap <leader>b :bd<cr>
" vertical/horizontal split
noremap <leader>s :vs<cr>
noremap <leader>S :split<cr>
" reload without save
noremap <leader>r :e!<cr>

inoremap <silent> <C-j> <Esc>o

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

noremap <silent> <tab>t :tabnew<CR>:vs<CR>
noremap <silent> <tab>e :tabclose<CR>
noremap <silent> <tab>n :tabn<CR>
noremap <silent> <tab>p :tabp<CR>
noremap <silent> <leader>1 :tabn 1<CR>
noremap <silent> <leader>2 :tabn 2<CR>
noremap <silent> <leader>3 :tabn 3<CR>
noremap <silent> <leader>4 :tabn 4<CR>
noremap <silent> <leader>5 :tabn 5<CR>
noremap <silent> <leader>6 :tabn 6<CR>
noremap <silent> <leader>7 :tabn 7<CR>
noremap <silent> <leader>8 :tabn 8<CR>
noremap <silent> <leader>9 :tabn 9<CR>
noremap <silent> <leader>0 :tabn 0<CR>

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
nnoremap j gj
nnoremap k gk
nnoremap <M-j> 5jzz
nnoremap <M-k> 5kzz

" 给一个 word 添加双引号
nnoremap <leader>" viw<Esc>a"<Esc>hbi"<Esc>lel

inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<ESC>O
inoremap {<C-j> {<CR>}<ESC>O
inoremap {} {}
inoremap {;p {<CR>};<ESC>O<ESC>ipublic:<ESC><<I<SPACE><ESC>o<BS>

inoremap ( ()<ESC>i
inoremap () ()
inoremap [ []<ESC>i
inoremap [] []
inoremap < <><ESC>i
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

inoremap <C-l> <Right>

nnoremap <BackSpace> :nohl<Cr>

" 分别找到最近的括号
onoremap in( :<C-u>normal! f(vi(<Cr>
onoremap il( :<C-u>normal! F)vi(<Cr>

"vim 和终端背景一致：添加下面到 .vimrc
hi Normal ctermfg=252 ctermbg=none

" 输入相关
inoremap <leader>; <Esc>A;
nnoremap <leader>; <Esc>A;<Esc>

function! MakeOrRemoveComment()
  let l:line = getline(".")
  " now is in head after motion ^
  let l:current_col = col(".")
  if l:line[l:current_col - 1] == "/"
    if l:current_col == col("$") - 1
      execute "normal! I//\<Esc>`p\<Right>\<Right>"
      return
    endif
    if l:line[l:current_col] == "/"
      execute "normal! xx`p\<Left>\<Left>"
    else
      execute "normal! I//\<Esc>`p\<Right>\<Right>"
    endif
  else
    execute "normal! I//\<Esc>`p\<Right>\<Right>"
  endif
endfunction

" make /* */ block comments
nnoremap <leader>c <Esc>mp^:call MakeOrRemoveComment()<Cr>
