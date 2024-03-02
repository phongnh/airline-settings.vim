if exists('g:loaded_airline_settings')
    finish
endif
let g:loaded_airline_settings = 1

let s:save_cpo = &cpo
set cpo&vim

" Disable vim-devicons integration for Airline's statusline
let g:webdevicons_enable_airline_statusline = 0

" Settings
let g:airline_powerline_fonts = get(g:, 'airline_powerline_fonts', 0)
let g:airline_show_devicons   = get(g:, 'airline_show_devicons',   1)
let g:airline_show_git_branch = get(g:, 'airline_show_git_branch', 1)
let g:airline_show_vim_logo   = get(g:, 'airline_show_vim_logo',   1)
let g:airline_show_linenr     = get(g:, 'airline_show_linenr',     0)

" Window width
let g:airline_winwidth_config = extend({
            \ 'compact': 60,
            \ 'small':  80,
            \ 'normal': 120,
            \ }, get(g:, 'airline_winwidth_config', {}))

" Disable some extensions
let g:airline_ignore_extensions = [
            \ 'battery',
            \ 'bookmark',
            \ 'bufferline',
            \ 'capslock',
            \ 'commandt',
            \ 'csv',
            \ 'ctrlspace',
            \ 'cursormode',
            \ 'denite',
            \ 'dirvish',
            \ 'eclim',
            \ 'example',
            \ 'fern',
            \ 'gina',
            \ 'gen_tags',
            \ 'hunks',
            \ 'keymap',
            \ 'localsearch',
            \ 'obsession',
            \ 'omnisharp',
            \ 'po',
            \ 'poetv',
            \ 'promptline',
            \ 'rufo',
            \ 'scrollbar',
            \ 'searchcount',
            \ 'taglist',
            \ 'tmuxline',
            \ 'unicode',
            \ 'unite',
            \ 'vimagit',
            \ 'vimcmake',
            \ 'vimodoro',
            \ 'vimtex',
            \ 'virtualenv',
            \ 'vista',
            \ 'whitespace',
            \ 'windowswap',
            \ 'wordcount',
            \ 'xkblayout',
            \ 'zoomwintab',
            \ ]

for ext in g:airline_ignore_extensions
    let g:airline#extensions#{ext}#enabled = 0
endfor

let g:airline#extensions#branch#enabled = g:airline_show_git_branch
" Branch - show only 30 characters of branch name
let g:airline#extensions#branch#displayed_head_limit = 30

" Disable truncation
let g:airline#extensions#default#section_truncate_width = {}

" Enable iminsert
let g:airline_detect_iminsert = 1

" Enable spellang flags
let g:airline_detect_spelllang = 'flag'

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

if !exists('g:airline_filetype_overrides')
    let g:airline_filetype_overrides = {}
endif

call extend(g:airline_filetype_overrides, {
            \ 'dirvish':         ['Dirvish', '%{airline_settings#dirvish#Folder()}'],
            \ 'molder':          ['Molder', '%{airline_settings#molder#Folder()}'],
            \ 'fern':            ['%{airline_settings#fern#Mode()}', '%{airline_settings#fern#Folder()}'],
            \ 'carbon.explorer': ['Carbon', '%{airline_settings#carbon#Folder()}'],
            \ 'neo-tree':        ['NeoTree', '%{airline_settings#neotree#Folder()}'],
            \ 'oil':             ['Oil', '%{airline_settings#oil#Folder()}'],
            \ 'NvimTree':        ['NvimTree', ''],
            \ 'CHADTree':        ['CHADTree', ''],
            \ 'alpha':           ['Alpha', ''],
            \ })

" Define extra parts
call airline#parts#define_function('settings', 'airline_settings#parts#Settings')
call airline#parts#define_function('indentation', 'airline_settings#parts#Indentation')
call airline#parts#define_function('ffenc', 'airline_settings#parts#FileEncodingAndFormat')

" Show only mode, clipboard, paste and spell
let g:airline_section_a = airline#section#create_left([
            \ 'mode',
            \ 'settings',
            \ 'crypt',
            \ 'keymap',
            \ 'iminsert',
            \ ])

" Move filetype into other section
let g:airline_section_x = airline#section#create_right([
            \ 'tagbar',
            \ 'gutentags',
            \ 'gen_tags',
            \ 'grepper',
            \ ])

" Add indentation, file encoding, file format and file type info
let g:airline_section_y = airline#section#create_right([
            \ 'indentation',
            \ 'ffenc',
            \ 'filetype',
            \ ])

if g:airline_show_devicons
    " Append DevIcons
    let g:airline_section_y .= '%( %{airline_settings#parts#FileTypeIcon()} %)'
endif

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
    autocmd User AirlineAfterInit call airline_settings#AfterInit()
    autocmd VimEnter * call airline_settings#Init()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
