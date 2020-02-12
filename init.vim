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

noremap <Esc><Esc> :<C-u>nohlsearch<CR><Esc>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Ripgrep command on grep source
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep', '--no-heading'])

call denite#custom#source('file/old', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
call denite#custom#source('tag', 'matchers', ['matcher/substring'])
call denite#custom#source('file/rec', 'matchers', ['matcher/fuzzy'])
call denite#custom#source('file/old,ghq', 'converters', ['converter/relative_word', 'converter/relative_abbr'])

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])


let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'typescript.tsx': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'vue': ['eslint'],
      \ 'python': ['autopep8', 'black', 'isort'],
      \ 'php': ['phpcbf'],
      \ }

let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'typescript.tsx': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'vue': ['eslint'],
      \ 'python': ['autopep8', 'black', 'isort'],
      \ 'php': ['phpcbf'],
      \ }

let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

autocmd MyAutoCmd FileType typescript nnoremap <buffer> <C-]> :<C-u>ALEGoToDefinitionInVSplit <CR>

nnoremap [gitorgo] <Nop>
nmap <C-g> [gitorgo]
nnoremap [gitorgo]s     :Gstatus<CR>
nnoremap [gitorgo]<C-s> :Gstatus<CR>
nnoremap [gitorgo]g     :Gstatus<CR>
nnoremap [gitorgo]<C-g> :Gstatus<CR>
nnoremap [gitorgo]a     :Gwrite<CR>
nnoremap [gitorgo]<C-a> :Gwrite<CR>
nnoremap [gitorgo]c     :Gcommit<CR>
nnoremap [gitorgo]<C-c> :Gcommit<CR>
nnoremap [gitorgo]b     :Gblame<CR>
nnoremap [gitorgo]<C-b> :Gblame<CR>
nnoremap [gitorgo]d     :Gdiff<CR>
nnoremap [gitorgo]<C-d> :Gdiff<CR>
nnoremap [gitorgo]m     :Gmerge<CR>
nnoremap [gitorgo]<C-m> :Gmerge<CR>
nnoremap [gitorgo]j     :GitGutterNextHunk<CR>
nnoremap [gitorgo]<C-j> :GitGutterNextHunk<CR>
nnoremap [gitorgo]k     :GitGutterPrevHunk<CR>
nnoremap [gitorgo]<C-k> :GitGutterPrevHunk<CR>
nnoremap [gitorgo]u     :GitGutterUndoHunk<CR>
nnoremap [gitorgo]<C-u> :GitGutterUndoHunk<CR>
nnoremap [gitorgo]t     :<C-u>:GoTest<CR>
nnoremap [gitorgo]<C-t> :<C-u>:GoTest<CR>
nnoremap [gitorgo]r     :<C-u>:GoRun<CR>
nnoremap [gitorgo]<C-r> :<C-u>:GoRun<CR>
nnoremap [gitorgo]l     :<C-u>:GoLint<CR>
nnoremap [gitorgo]<C-l> :<C-u>:GoLint<CR>
nnoremap [gitorgo]e     :<C-u>:GoIfErr<CR>
nnoremap [gitorgo]<C-e> :<C-u>:GoIfErr<CR>
inoremap [gitorgo]e     <Esc>:<C-u>:GoIfErr<CR>i
inoremap [gitorgo]<C-e> <Esc>:<C-u>:GoIfErr<CR>i
nnoremap [gitorgo]n     :<C-u>:cnext<CR>
nnoremap [gitorgo]<C-n> :<C-u>:cnext<CR>
nnoremap [gitorgo]p     :<C-u>:cprev<CR>
nnoremap [gitorgo]<C-p> :<C-u>:cprev<CR>

tnoremap <C-[> <C-\><C-n>
nnoremap <C-t> :<C-u>split<CR><c-w>-<c-w>-<c-w>-<c-w>-<c-w>-<c-w>-<c-w>-<c-w>-:terminal<CR>i

nnoremap ; :
nnoremap : ;

command W w
command Q q

tnoremap <C-[> <C-\><C-n>

autocmd QuickFixCmdPost * :copen
:command M silent make
