
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" reset augroup
augroup MyAutoCmd
autocmd!
augroup END

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.config/nvim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

set hidden
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set belloff=all
set splitright
set clipboard=unnamed
set hls
set noswapfile
syntax on

set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

noremap <Esc><Esc> :<C-u>nohlsearch<CR><Esc>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#var('file/rec', 'command',
	\ ['ag', '--follow', '--nocolor', '--nogroup', '--ignore', 'node_modules', '--ignore', 'screenshots', '-g', ''])
call denite#custom#source(
	\ 'file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])

call denite#custom#source('file/rec', 'matchers', ['matcher/fuzzy', 'matcher/hide_hidden_files'])

call denite#custom#source(
	\ 'file/rec', 'sorters', ['sorter/sublime'])

let g:ale_php_phpcbf_standard = 'psr2'

let g:ale_fixers = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'vue': ['eslint', 'prettier'],
      \ 'python': ['autopep8', 'isort'],
      \ 'php': ['phpcbf'],
      \ }
let g:ale_fix_on_save = 1

set wildmenu
set wildmode=list:longest
set signcolumn=yes
set updatetime=1000

nnoremap [git]  <Nop>
nmap <C-g> [git]
nnoremap [git]s :Gstatus<CR>
nnoremap [git]g :Gstatus<CR>
nnoremap [git]<C-g> :Gstatus<CR>
nnoremap [git]a :Gwrite<CR>
nnoremap [git]c :Gcommit<CR>
nnoremap [git]b :Gblame<CR>
nnoremap [git]d :Gdiff<CR>
nnoremap [git]m :Gmerge<CR>
nnoremap [git]j :GitGutterNextHunk<CR>
nnoremap [git]k :GitGutterPrevHunk<CR>
nnoremap [git]u :GitGutterUndoHunk<CR>

command W w
command Q q

