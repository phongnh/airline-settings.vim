function! airline_settings#Trim(str) abort
    return substitute(a:str, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

if exists('*trim')
    function! airline_settings#Trim(str) abort
        return trim(a:str)
    endfunction
endif

function! airline_settings#IsClipboardEnabled() abort
    return match(&clipboard, 'unnamed') > -1
endfunction

function! airline_settings#IsCompact(...) abort
    let l:winnr = get(a:, 1, 0)
    return winwidth(l:winnr) <= g:airline_winwidth_config.compact ||
                \ count([
                \   airline_settings#IsClipboardEnabled(),
                \   &paste,
                \   &spell,
                \   &bomb,
                \   !&eol,
                \ ], 1) > 1
endfunction

function! airline_settings#Concatenate(parts, ...) abort
    let separator = get(a:, 1, 0) ? g:airline_right_alt_sep : g:airline_left_alt_sep
    return join(filter(copy(a:parts), 'v:val !=# ""'), g:airline_symbols.space . separator . g:airline_symbols.space)
endfunction

function! airline_settings#BufferType() abort
    return strlen(&filetype) ? &filetype : &buftype
endfunction

function! airline_settings#FileName() abort
    let fname = expand('%')
    return strlen(fname) ? fnamemodify(fname, ':~:.') : '[No Name]'
endfunction

function! airline_settings#Setup() abort
    " Disable vim-devicons integration for Airline's statusline
    let g:webdevicons_enable_airline_statusline = 0

    " Settings
    let g:airline_powerline_fonts = get(g:, 'airline_powerline_fonts', 0)
    let g:airline_show_devicons   = get(g:, 'airline_show_devicons',   1)
    let g:airline_show_git_branch = get(g:, 'airline_show_git_branch', 1)
    let g:airline_show_linenr     = get(g:, 'airline_show_linenr',     0)
    let g:airline_show_vim_logo   = get(g:, 'airline_show_vim_logo',   1)

    " Window width
    let g:airline_winwidth_config = extend({
                \ 'compact': 60,
                \ 'small':   80,
                \ 'normal':  120,
                \ }, get(g:, 'airline_winwidth_config', {}))

    " Do not draw separators for empty sections for the active window
    " let g:airline_skip_empty_sections = 1

    " Enable iminsert
    let g:airline_detect_iminsert = 1

    " Enable spellang flags
    let g:airline_detect_spelllang = get(g:, 'airline_detect_spelllang', 1)

    " Disable truncation
    let g:airline#extensions#default#section_truncate_width = {}

    " Enable tabline
    let g:airline#extensions#tabline#enabled         = 1
    let g:airline#extensions#tabline#show_splits     = 0
    let g:airline#extensions#tabline#show_tab_count  = 0
    let g:airline#extensions#tabline#tab_nr_type     = 1
    let g:airline#extensions#tabline#tabnr_formatter = 'simple'
    let g:airline#extensions#tabline#tabs_label      = 'Tabs'
    let g:airline#extensions#tabline#buffers_label   = 'Buffers'
    let g:airline#extensions#tabline#buffer_nr_show  = 1
    let g:airline#extensions#tabline#fnamemod        = ':t'
    let g:airline#extensions#tabline#fnametruncate   = 30

    let g:airline#extensions#branch#enabled = g:airline_show_git_branch
    " Branch - show only 30 characters of branch name
    let g:airline#extensions#branch#displayed_head_limit = 30
    " Disable untracked and dirty checks
    let g:airline#extensions#branch#vcs_checks = []

    " Don't show 'utf-8[unix]'
    let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'

    " Symbols: https://en.wikipedia.org/wiki/Enclosed_Alphanumerics
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    call extend(g:airline_symbols, {
                \ 'dos':        '[dos]',
                \ 'mac':        '[mac]',
                \ 'unix':       '[unix]',
                \ 'bomb':       '🅑 ',
                \ 'noeol':      '∉ ',
                \ 'clipboard':  '🅒 ',
                \ 'paste':      '🅟 ',
                \ 'spell':      '🅢 ',
                \ 'whitespace': 'Ξ',
                \ 'dirty':      '',
                \ })

    if g:airline_powerline_fonts
        call airline_settings#powerline#SetSeparators(get(g:, 'airline_powerline_style', 'default'), get(g:, 'airline_powerline_tab_style', 'default'))
    else
        let g:airline_left_sep      = ''
        let g:airline_right_sep     = ''
        let g:airline_left_alt_sep  = '|'
        let g:airline_right_alt_sep = '|'

        let g:airline#extensions#tabline#left_sep      = ' '
        let g:airline#extensions#tabline#right_sep     = ''
        let g:airline#extensions#tabline#left_alt_sep  = '|'
        let g:airline#extensions#tabline#right_alt_sep = '|'
        let g:airline#extensions#tabline#close_symbol  = '×'

        let g:airline_symbols.clipboard .= ' '
        call extend(g:airline_symbols, {
                    \ 'branch':   '⎇ ',
                    \ 'readonly': '',
                    \ })
    endif

    let g:airline_show_devicons = g:airline_show_devicons && airline_settings#devicons#Detect()

    if g:airline_show_devicons
        call extend(g:airline_symbols, {
                    \ 'bomb':  "\ue287 ",
                    \ 'noeol': "\ue293 ",
                    \ 'dos':   "\ue70f",
                    \ 'mac':   "\ue711",
                    \ 'unix':  "\ue712",
                    \ })
        let g:airline_symbols.unix = '[unix]'
    endif

    if g:airline_show_devicons && g:airline_show_vim_logo
        " Show Vim Logo in Tabline
        let g:airline#extensions#tabline#tabs_label    = "\ue7c5" . ' '
        let g:airline#extensions#tabline#buffers_label = "\ue7c5" . ' '
    endif

    " Disable some extensions
    let g:airline#extensions#battery#enabled     = 0
    let g:airline#extensions#bookmark#enabled    = 0
    let g:airline#extensions#bufferline#enabled  = 0
    let g:airline#extensions#capslock#enabled    = 0
    let g:airline#extensions#commandt#enabled    = 0
    let g:airline#extensions#csv#enabled         = 0
    let g:airline#extensions#ctrlspace#enabled   = 0
    let g:airline#extensions#cursormode#enabled  = 0
    let g:airline#extensions#denite#enabled      = 0
    let g:airline#extensions#dirvish#enabled     = 0
    let g:airline#extensions#eclim#enabled       = 0
    let g:airline#extensions#example#enabled     = 0
    let g:airline#extensions#fern#enabled        = 0
    let g:airline#extensions#gina#enabled        = 0
    let g:airline#extensions#gen_tags#enabled    = 0
    let g:airline#extensions#hunks#enabled       = 0
    let g:airline#extensions#keymap#enabled      = 0
    let g:airline#extensions#localsearch#enabled = 0
    let g:airline#extensions#obsession#enabled   = 0
    let g:airline#extensions#omnisharp#enabled   = 0
    let g:airline#extensions#po#enabled          = 0
    let g:airline#extensions#poetv#enabled       = 0
    let g:airline#extensions#promptline#enabled  = 0
    let g:airline#extensions#rufo#enabled        = 0
    let g:airline#extensions#scrollbar#enabled   = 0
    let g:airline#extensions#searchcount#enabled = 0
    let g:airline#extensions#taglist#enabled     = 0
    let g:airline#extensions#tmuxline#enabled    = 0
    let g:airline#extensions#unicode#enabled     = 0
    let g:airline#extensions#unite#enabled       = 0
    let g:airline#extensions#vimagit#enabled     = 0
    let g:airline#extensions#vimcmake#enabled    = 0
    let g:airline#extensions#vimodoro#enabled    = 0
    let g:airline#extensions#vimtex#enabled      = 0
    let g:airline#extensions#virtualenv#enabled  = 0
    let g:airline#extensions#vista#enabled       = 0
    let g:airline#extensions#whitespace#enabled  = 0
    let g:airline#extensions#windowswap#enabled  = 0
    let g:airline#extensions#wordcount#enabled   = 0
    let g:airline#extensions#xkblayout#enabled   = 0
    let g:airline#extensions#zoomwintab#enabled  = 0
endfunction

function! airline_settings#AirlineAfterInit() abort
    setglobal showtabline=1 noshowmode

    " Integrate with gutentags and grepper
    let g:airline_section_x = airline#section#create_right([
                \ 'gutentags',
                \ 'grepper',
                \ ])

    " call airline#parts#define_condition('gutentags', 'g:loaded_gutentags == 1')
    " call airline#parts#define_condition('grepper', 'g:loaded_grepper == 1')
 
    " Overwrite for Terminal
    call airline#parts#define('linenr', {
                \ 'raw':    '%l',
                \ 'accent': 'bold',
                \ })

    " Overwrite for Terminal
    call airline#parts#define('maxlinenr', {
                \ 'raw':    '/%L',
                \ 'accent': 'bold',
                \ })

    if g:airline_show_linenr > 0
        if g:airline_show_linenr > 2
            let l:format = '%4l:%-3v %P'
        elseif g:airline_show_linenr > 1
            let l:format = '%4l:%-3v' 
        else
            let l:format = '%3l:%-3v'
        endif
        call airline#parts#define('lineinfo', {
                    \ 'raw':    l:format,
                    \ 'accent': 'bold',
                    \ })
        let g:airline_section_z = airline#section#create(['lineinfo'])
    else
        " Hide percentage, linenr, maxlinenr and column
        let g:airline_section_z = ''
    endif
endfunction

function! airline_settings#Init() abort
    " Copied from https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/extensions/tabline/formatters/default.vim
    " Show buffer nr in Buffers mode
    function! airline#extensions#tabline#formatters#default#wrap_name(bufnr, buffer_name) abort
        let buf_nr_format = get(g:, 'airline#extensions#tabline#buffer_nr_format', '%s: ')
        let buf_nr_show = tabpagenr('$') == 1

        let _ = buf_nr_show ? printf(buf_nr_format, a:bufnr) : ''
        let _ .= substitute(a:buffer_name, '\\', '/', 'g')

        if getbufvar(a:bufnr, '&modified') == 1
            let _ .= g:airline_symbols.modified
        endif
        return _
    endfunction
endfunction
