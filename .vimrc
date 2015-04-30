" Partially stolen from http://github.com/timss/vimconf "

" vimconf is not vi-compatible
set nocompatible

" Automatically make needed files and folders on first run
" If you don't run *nix you're on your own (as in remove this)
    call system("mkdir -p $HOME/.vim/{swap,undo}")
"
" Vundle plugin manager
    " Automatically setting up Vundle, taken from
    " http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
        let has_vundle=1
        if !filereadable($HOME."/.vim/bundle/Vundle.vim/README.md")
            echo "Installing Vundle..."
            echo ""
            silent !mkdir -p $HOME/.vim/bundle
            silent !git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
            let has_vundle=0
        endif
    "
    " Initialize Vundle
        filetype off                                " required to init
        set rtp+=$HOME/.vim/bundle/Vundle.vim       " include vundle
        call vundle#begin()                         " init vundle
    "
    " Github repos, uncomment to disable a plugin
    Plugin 'gmarik/Vundle.vim'

    " Glorious colorschemes
    Plugin 'nanotech/jellybeans.vim'
    Plugin 'freeo/vim-kalisi'

    " Easy... motions... yeah.
    Plugin 'Lokaltog/vim-easymotion'

    " Fuzzy file, buffer, mru, tag, etc finder
    Plugin 'https://github.com/kien/ctrlp.vim'

    " lean & mean status/tabline for vim that's light as air
    Plugin 'bling/vim-airline'

    " a fancy start screen for vim.
    Plugin 'mhinz/vim-startify'

    " A code-completion engine for Vim
    Plugin 'Valloric/YouCompleteMe'

    " buffer control
    Plugin 'jeetsukumaran/vim-buffergator'

    " A tree explorer plugin for vim
    Plugin 'scrooloose/nerdtree'

    " Vim plugin, provides insert mode auto-completion for quotes, parens,
    " brackets, etc.
    Plugin 'Raimondi/delimitMate'

    " Vim plugin for creating tmux conf file with same color scheme
    Plugin 'edkolev/tmuxline.vim'

    " Finish Vundle stuff
    call vundle#end()

    " Installing plugins the first time, quits when done
        if has_vundle == 0
            :silent! PluginInstall
            :qa
        endif
    "
"
" User interface
    " Syntax highlighting
        filetype plugin indent on                   " detect file plugin+indent
        syntax on                                   " syntax highlighting
        set background=dark                         " we're using a dark bg
        colorscheme jellybeans
        " force behavior and filetypes, and by extension highlighting
            augroup FileTypeRules
                autocmd!
                autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
                autocmd BufNewFile,BufRead *.conf set ft=cfg tw=79
                autocmd BufNewFile,BufRead *.md set ft=markdown tw=79
                autocmd BufNewFile,BufRead *.tex set ft=tex tw=79
                autocmd BufNewFile,BufRead *.txt set ft=sh tw=79
            augroup END
        "
        " 256 colors for maximum jellybeans bling. See commit log for info
            if (&term =~ "xterm") || (&term =~ "screen")
                set t_Co=256
            endif
        "
        " Custom highlighting, where NONE uses terminal background
            function! CustomHighlighting()
                highlight Normal ctermbg=NONE
                highlight NonText ctermbg=NONE
                highlight LineNr ctermbg=NONE
                highlight SignColumn ctermbg=NONE
                highlight SignColumn guibg=#151515
                highlight CursorLine ctermbg=235
            endfunction

            "call CustomHighlighting()
        "
    "
    " Interface general
        set cursorline                              " hilight cursor line
        set more                                    " ---more--- like less
        set number                                  " line numbers
        set scrolloff=3                             " lines above/below cursor
        set showcmd                                 " show cmds being typed
        set title                                   " window title
        set vb t_vb=                                " disable beep and flashing
        set wildignore=*.a,*.o,*.so,*.pyc,*.jpg,
                    \*.jpeg,*.png,*.gif,*.pdf,*.git,
                    \*.swp,*.swo                    " tab completion ignores
        set wildmenu                                " better auto complete
        set wildmode=longest,list                   " bash-like auto complete
        " Depending on your setup you may want to enforce UTF-8.
        " Should generally be set in your environment LOCALE/$LANG
            set encoding=utf-8                    " default $LANG/latin1
            set fileencoding=utf-8                " default none
            set fileencodings=utf8                " list of preferred encodings
        "
        " Gvim
            set guifont=DejaVu\ Sans\ Mono\ 9
            set guioptions-=m                       " remove menubar
            set guioptions-=T                       " remove toolbar
            set guioptions-=r                       " remove right scrollbar
        "
    "
"
" General settings
    set hidden                                      " buffer change, more undo
    set history=1000                                " default 20
    set iskeyword+=_,$,@,%,#                        " not word dividers
    set laststatus=2                                " always show statusline
    set linebreak                                   " don't cut words on wrap
    set listchars=tab:>-,trail:-                    " > to highlight <tab>
    set list                                        " displaying listchars
    set mouse=                                      " disable mouse
    "set noshowmode                                 " hide mode cmd line
    "set clipboard=x11-selection                    " use system buffer for 'y' and 'p'
    set virtualedit=all                             " On Virtual Edit for all modes
    set noexrc                                      " don't use other .*rc(s)
    set nostartofline                               " keep cursor column pos
    set nowrap                                      " don't wrap lines
    set numberwidth=5                               " 99999 lines
    set shortmess+=I                                " disable startup message
    set splitbelow                                  " splits go below w/focus
    set splitright                                  " vsplits go right w/focus
    set ttyfast                                     " for faster redraws etc
    set ttymouse=xterm2                             " experimental
    " Folding
        set foldcolumn=0                            " hide folding column
        set foldmethod=indent                       " folds using indent
        set foldnestmax=10                          " max 10 nested folds
        set foldlevelstart=99                       " folds open by default
    "
    " Search and replace
        set gdefault                                " default s//g (global)
        set incsearch                               " "live"-search
        set hlsearch                                " highlight matches
    "
    " Matching
        set matchtime=2                             " time to blink match {}
        set matchpairs+=<:>                         " for ci< or ci>
        set showmatch                               " tmpjump to match-bracket
    "
    " Return to last edit position when opening files
        augroup LastPosition
            autocmd! BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     exe "normal! g`\"" |
                \ endif
        augroup END
    "
"
" Files
    set autochdir                                   " always use curr. dir.
    set autoread                                    " refresh if changed
    set confirm                                     " confirm changed files
    set noautowrite                                 " never autowrite
    set nobackup
    " Persistent undo. Requires Vim 7.3
        if has('persistent_undo') && exists("&undodir")
            set undodir=$HOME/.vim/undo/            " where to store undofiles
            set undofile                            " enable undofile
            set undolevels=500                      " max undos stored
            set undoreload=10000                    " buffer stored undos
        endif
    "
    " Swap files, unless vim is invoked using sudo. Inspired by tejr's vimrc
    " https://github.com/tejr/dotfiles/blob/master/vim/vimrc
        if !strlen($SUDO_USER)
            set directory^=$HOME/.vim/swap//        " default cwd, // full path
            set swapfile                            " enable swap files
            set updatecount=50                      " update swp after 50chars
            " Don't swap tmp, mount or network dirs
                augroup SwapIgnore
                    autocmd! BufNewFile,BufReadPre /tmp/*,/mnt/*,/media/*
                                \ setlocal noswapfile
                augroup END
            "
        else
            set noswapfile                          " dont swap sudo'ed files
        endif
    "
"
" Text formatting
    set smartindent                                 " preserve indentation
    set backspace=indent,eol,start                  " smart backspace
    set cinkeys-=0#                                 " don't force # indentation
    set expandtab                                   " no real tabs
    set ignorecase                                  " by default ignore case
    set nrformats+=alpha                            " incr/decr letters C-a/-x
    set shiftround                                  " be clever with tabs
    set shiftwidth=4                                " default 8
    set smartcase                                   " sensitive with uppercase
    set smarttab                                    " tab to 0,4,8 etc.
    set softtabstop=4                               " "tab" feels like <tab>
"
" Keybindings
    " Remap <leader>
    let mapleader=","

    " Yank(copy) to system clipboard
    noremap <leader>y "+y
    noremap <leader>p "+p

    " Map Ctrl+C to copy in Visual mode
    vmap <C-C> "+y

    " Scroll up/down lines from 'scroll' option, default half a screen
    map <C-j> <C-d>
    map <C-k> <C-u>

    " Navigate with <Ctrl>-hjkl in Insert mode
    imap <C-h> <C-o>h
    imap <C-j> <C-o>j
    imap <C-k> <C-o>k
    imap <C-l> <C-o>l

    " Treat wrapped lines as normal lines
    nnoremap j gj
    nnoremap k gk

    " Fix arrow keys that display A B C D on remote shell
    imap <ESC>oA <ESC>ki
    imap <ESC>oB <ESC>ji
    imap <ESC>oC <ESC>li
    imap <ESC>oD <ESC>hi

    " Quickly edit/source .vimrc
    noremap <leader>ve :edit $HOME/.vimrc<CR>
    noremap <leader>vs :source $HOME/.vimrc<CR>

    " Save session
    nnoremap <leader>s :mksession!<CR>

    " Ctrl+s
    "noremap <C-s> <esc>:w<CR>
    "inoremap <C-s> <esc>:w<CR>

    " Buffers, preferred over tabs now with bufferline.
    nnoremap gn :bnext<CR>
    nnoremap gN :bprevious<CR>
    "nnoremap gd :bdelete<CR>
    "nnoremap gf <C-^>

    " Useful mappings for managing tabs
    map <leader>tn :tabnew<cr>
    map <leader>tc :tabclose<cr>
    map <leader>tm :tabmove

    " tab navigation like firefox
    " nnoremap <C-S-tab> :tabprevious<CR>
    " nnoremap <C-tab>   :tabnext<CR>
    " inoremap <C-S-tab> <Esc>:tabprevious<CR>i
    " inoremap <C-tab>   <Esc>:tabnext<CR>i
    " nnoremap <C-Insert> :tabnew<CR>
    " nnoremap <C-Delete> :tabclose<CR>

    nnoremap <F3> <Esc>:w<CR>
    "nnoremap <F4> <Esc>:browse tabnew<CR>
    "nnoremap <F5> <Esc>:tabprevious<CR>
    "nnoremap <F6> <Esc>:tabnext<CR>
    "inoremap <F5> <Esc>:tabprevious<CR>
    "inoremap <F6> <Esc>:tabnext<CR>

    " jk is escape
    inoremap jk <esc>

    " turn off search highlight
    nnoremap <leader><space> :nohlsearch<CR>
"
" Plugin options
    " CtrlP settings
        let g:ctrlp_match_window = 'bottom,order:ttb'
        let g:ctrlp_switch_buffer = 0
        let g:ctrlp_working_path_mode = 'ra'
        let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

        " Buffer controls to go with Buffergator
        nmap <leader>bb :CtrlPBuffer<cr>
        nmap <leader>bm :CtrlPMixed<cr>
        nmap <leader>bs :CtrlPMRU<cr>
    "
    " airline and tmux.vim settings
        " Enable the list of buffers
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_left_sep = ''
        let g:airline_right_sep = ''
        let g:airline_theme='jellybeans'
        "let g:airline_theme='kalisi'

        let g:airline#extensions#tmuxline#enabled = 1
        let g:airline#extensions#tmuxline#snapshot_file = "~/.tmux-statusline-colors.conf"
        let g:tmuxline_separators = {
            \ 'left' : '',
            \ 'left_alt': '>',
            \ 'right' : '',
            \ 'right_alt' : '<',
            \ 'space' : ' '}
    "
    " Easy motion
        map <space> <Plug>(easymotion-prefix)

        let g:EasyMotion_smartcase = 1
        map <space>l <Plug>(easymotion-lineforward)
        map <space>j <Plug>(easymotion-j)
        map <space>k <Plug>(easymotion-k)
        map <space>h <Plug>(easymotion-linebackward)

        let g:EasyMotion_startofline = 0
    "

    " Buffergator Options
        " I want my own keymappings...
        let g:buffergator_suppress_keymaps = 1

        " Looper!
        "let g:buffergator_mru_cycle_loop = 1

        nmap <leader>T :enew<cr>
        nmap <leader>jj :BuffergatorMruCyclePrev<cr>
        nmap <leader>kk :BuffergatorMruCycleNext<cr>
        nmap <leader>bq :bp <BAR> bd #<cr>
    "
    " YCM
        " Ignore certain filetypes
        let g:ycm_filetype_blacklist = {
                  \ 'tagbar': 1,
                  \ 'qf': 1,
                  \ 'notes': 1,
                  \ 'markdown': 1,
                  \ 'unite': 1,
                  \ 'text': 1,
                  \ 'vimwiki': 1,
                  \ 'pandoc': 1,
                  \ 'infolog': 1,
                  \ 'mail': 1,
                  \ 'gitcommit': 1,
                  \}

        let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
        let g:ycm_server_keep_logfiles = 1
        "let g:ycm_server_log_level = 'debug'

        " Fast jump to defenition or declaration
        nnoremap <leader>jd :YcmCompleter GoTo<CR>
    "
    " NerdTree
        " fast toggling of nerdtree window
        map <C-n> :NERDTreeToggle<CR>
    "
"
