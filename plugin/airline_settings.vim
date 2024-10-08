if exists('g:loaded_airline_settings')
    finish
endif
let g:loaded_airline_settings = 1

let s:save_cpo = &cpo
set cpo&vim

" Settings
let g:airline_powerline_fonts = get(g:, 'airline_powerline_fonts', 0)
let g:airline_show_git_branch = get(g:, 'airline_show_git_branch', 0)
let g:airline_show_linenr     = get(g:, 'airline_show_linenr',     0)
let g:airline_show_devicons   = get(g:, 'airline_show_devicons',   0) && airline_settings#devicons#Detect()

" Window width
let g:airline_winwidth_config = extend({
            \ 'compact': 60,
            \ 'default': 90,
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

if g:airline_powerline_fonts || g:airline_show_devicons
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

if g:airline_show_devicons
    call extend(g:airline_symbols, {
                \ 'bomb':  "\ue287 ",
                \ 'noeol': "\ue293 ",
                \ 'dos':   "\ue70f",
                \ 'mac':   "\ue711",
                \ 'unix':  "\ue712",
                \ })
    let g:airline_symbols.unix = '[unix]'
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

" Setup sections
if !exists('g:airline_filetype_overrides')
    let g:airline_filetype_overrides = {}
endif

call extend(g:airline_filetype_overrides, {
            \ 'simplebuffer':    ['SimpleBuffer', ''],
            \ 'dirvish':         ['Dirvish', '%{airline_settings#dirvish#Folder()}'],
            \ 'molder':          ['Molder', '%{airline_settings#molder#Folder()}'],
            \ 'fern':            ['%{airline_settings#fern#Mode()}', '%{airline_settings#fern#Folder()}'],
            \ 'carbon.explorer': ['Carbon', '%{airline_settings#carbon#Folder()}'],
            \ 'neo-tree':        ['NeoTree', '%{airline_settings#neotree#Folder()}'],
            \ 'oil':             ['Oil', '%{airline_settings#oil#Folder()}'],
            \ 'NvimTree':        ['NvimTree', ''],
            \ 'CHADTree':        ['CHADTree', ''],
            \ 'alpha':           ['Alpha', ''],
            \ 'dashboard':       ['Dashboard', ''],
            \ 'ministarter':     ['Starter', ''],
            \ 'vista':           ['Vista', '%{airline_settings#vista#Mode()}'],
            \ 'vista_kind':      ['Vista', '%{airline_settings#vista#Mode()}'],
            \ 'startuptime':     ['StartupTime'],
            \ })

" Define extra parts
call airline#parts#define_function('status', 'airline_settings#parts#Status')
call airline#parts#define_function('settings', 'airline_settings#parts#Settings')
call airline#parts#define_function('filetype', 'airline_settings#parts#FileType')

" Show only mode, clipboard, paste and spell
let g:airline_section_a = airline#section#create_left([
            \ 'mode',
            \ 'status',
            \ 'crypt',
            \ 'iminsert',
            \ ])

if g:airline_show_git_branch
    let g:airline_section_b = airline#section#create(['branhch'])
else
    let g:airline_section_b = ''
endif

" Add indentation, file encoding, file format and file type info
let g:airline_section_y = airline#section#create_right([
            \ 'settings',
            \ 'filetype',
            \ ])

let g:airline_section_error = airline#section#create([
            \ 'neomake_error_count',
            \ 'ale_error_count',
            \ 'lsp_error_count',
            \ 'nvimlsp_error_count',
            \ 'vim9lsp_error_count',
            \ ])

let g:airline_section_warning = airline#section#create([
            \ 'neomake_warning_count',
            \ 'ale_warning_count',
            \ 'lsp_warning_count',
            \ 'nvimlsp_warning_count',
            \ 'vim9lsp_warning_count',
            \ 'whitespace',
            \ ])

augroup AirlineSettings
    autocmd!
    autocmd User AirlineAfterInit call airline_settings#AirlineAfterInit()
    autocmd VimEnter * call airline_settings#Init()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
