" Plugins
call plug#begin('~/.local/share/nvim/plugged')
	" Gruvbox theme
	Plug 'morhetz/gruvbox'
	
	" File browser
	Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
	Plug 'Xuyuanp/nerdtree-git-plugin'

	" Language client
	Plug 'autozimu/LanguageClient-neovim', {
		\'branch': 'next',
		\'do': 'bash install.sh',
	\}

	" Deoplete completion menu
	if has('nvim')
  		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	else
  		Plug 'Shougo/deoplete.nvim'
  		Plug 'roxma/nvim-yarp'
 	 	Plug 'roxma/vim-hug-neovim-rpc'
	endif
	let g:deoplete#enable_at_startup = 1
	Plug 'Shougo/neosnippet.vim'
	Plug 'Shougo/neosnippet-snippets'

	" Multi-entry selection UI. FZF
	Plug 'junegunn/fzf', { 'dir': '~/sgoinfre/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'

	" Git Wrapper
	Plug 'tpope/vim-fugitive'

	" Vim surround
	Plug 'tpope/vim-surround'

	" 42 headers
	Plug 'pbondoer/vim-42header'

	" LLDB
	Plug 'dbgx/lldb.nvim'
call plug#end()

" turn hybrid line numbers on
:set number relativenumber
:set nu rnu

" Enable colorsheme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme gruvbox

" Start NERDTree automatically
autocmd vimenter * NERDTree

" NERDTree toggle shortcut
map <C-f> :NERDTreeToggle<CR>

" Close vim if last buffer is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree colors by file extension
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" Language Client settings
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
    \ }

let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Indentation
set autoindent noexpandtab tabstop=4 shiftwidth=4

" Show tabs
set list
set listchars=tab:>-

