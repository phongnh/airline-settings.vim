if exists('g:loaded_airline_settings')
    finish
endif
let g:loaded_airline_settings = 1

" Window width
let s:xsmall_window_width = 60
let s:small_window_width  = 80

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

let g:airline#extensions#branch#enabled = get(g:, 'airline_show_git_branch', 1)

" Disable truncation
let g:airline#extensions#default#section_truncate_width = {}

" Enable iminsert
let g:airline_detect_iminsert = 1

" Enable tabline
let g:airline#extensions#tabline#enabled         = 1
let g:airline#extensions#tabline#show_splits     = 0
let g:airline#extensions#tabline#show_tab_count  = 0
let g:airline#extensions#tabline#tab_nr_type     = 1
let g:airline#extensions#tabline#tabnr_formatter = 'custom_tabnr'
let g:airline#extensions#tabline#tabs_label      = 'Tabs'
let g:airline#extensions#tabline#buffers_label   = 'Buffers'
let g:airline#extensions#tabline#buffer_nr_show  = 1
let g:airline#extensions#tabline#fnamemod        = ':t'
let g:airline#extensions#tabline#fnametruncate   = 30

function! OverwriteDefaultFormat() abort
    " Copied from vim-airline
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

augroup airline-settings
    autocmd!
    autocmd VimEnter * call OverwriteDefaultFormat()
augroup END

" Branch - show only 30 characters of branch name
let g:airline#extensions#branch#displayed_head_limit = 30

" Don't show 'utf-8[unix]'
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'

" Symbols: https://en.wikipedia.org/wiki/Enclosed_Alphanumerics
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
call extend(g:airline_symbols, {
            \ 'clipboard':  '🅒 ',
            \ 'paste':      '🅟 ',
            \ 'spell':      '🅢 ',
            \ 'whitespace': 'Ξ',
            \ 'dirty':      '',
            \ })

" vim-devicons or nerdfont.vim support
let g:airline_show_devicons = get(g:, 'airline_show_devicons', 1)

" Show Vim Logo in Tabline
let g:airline_show_vim_logo = get(g:, 'airline_show_vim_logo', 1)

" Powerline Fonts
let g:airline_powerline_fonts  = get(g:, 'airline_powerline_fonts', 0)

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

    let g:airline#extensions#tabline#close_symbol = '×'

    let g:airline_symbols.clipboard .= ' '
    let g:airline_symbols.branch     = ''
endif

" Define extra parts
call airline#parts#define_function('clipboard', 'AirlineClipboardStatus')
call airline#parts#define_function('indentation', 'AirlineIndentationStatus')
call airline#parts#define_function('ffenc', 'AirlineFileEncodingAndFormatStatus')

function! s:IsClipboardEnabled() abort
    return match(&clipboard, 'unnamed') > -1
endfunction

function! AirlineClipboardStatus() abort
    return s:IsClipboardEnabled() ? g:airline_symbols.clipboard : ''
endfunction

function! s:ActiveWindow() abort
    return get(w:, 'airline_active', 1)
endfunction

function! s:IsCompact() abort
    return &spell || &paste || s:IsClipboardEnabled() || winwidth(0) <= s:xsmall_window_width
endfunction

function! AirlineIndentationStatus() abort
    if !s:ActiveWindow() || winwidth(0) < s:small_window_width
        return ''
    endif

    let l:shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    if s:IsCompact()
        return printf(&expandtab ? 'SPC: %d' : 'TAB: %d', l:shiftwidth)
    else
        return printf(&expandtab ? 'Spaces: %d' : 'Tab Size: %d', l:shiftwidth)
    endif
endfunction

function! AirlineFileEncodingAndFormatStatus() abort
    let l:encoding = strlen(&fileencoding) ? &fileencoding : &encoding
    let l:bomb     = &bomb ? '[BOM]' : ''
    let l:format   = strlen(&fileformat) ? printf('[%s]', &fileformat) : ''

    " Skip common string utf-8[unix]
    if (l:encoding . l:format) ==# g:airline#parts#ffenc#skip_expected_string
        return l:bomb
    endif

    return l:encoding . l:bomb . l:format
endfunction

" Support https://github.com/nvim-neo-tree/neo-tree.nvim
function! AirlineNeoTreeSource(...) abort
    if exists('b:neo_tree_source')
        return b:neo_tree_source
    endif

    return ''
endfunction

" Support https://github.com/stevearc/oil.nvim
function! AirlineOilFolder(...) abort
    let l:oil_dir = expand('%')
    if l:oil_dir =~# '^oil://'
        let l:oil_dir = substitute(l:oil_dir, '^oil://', '', '')
        return fnamemodify(l:oil_dir, ':p:~:.:h')
    endif

    return ''
endfunction

" Support https://github.com/SidOfc/carbon.nvim
function! AirlineCarbonFolder(...) abort
    if exists('b:carbon')
        return fnamemodify(b:carbon['path'], ':p:~:.:h')
    endif

    return ''
endfunction

" Support lambdalisue/fern.vim
function! s:ParseFernName(fern_name) abort
    return matchlist(a:fern_name, '^fern://\(.\+\)/file://\(.\+\)\$')
endfunction

function! AirlineFernMode(...) abort
    let data = s:ParseFernName(get(a:, 1, expand('%')))

    if len(data)
        let fern_mode = get(data, 1, '')
        if match(fern_mode, 'drawer') > -1
            return 'Drawer'
        endif
    endif

    return 'Fern'
endfunction

function! AirlineFernFolder(...) abort
    if !s:ActiveWindow()
        return ''
    endif

    let data = s:ParseFernName(get(a:, 1, expand('%')))

    if len(data)
        let fern_folder = get(data, 2, '')
        let fern_folder = substitute(fern_folder, ';\?\(#.\+\)\?\$\?$', '', '')
        let fern_folder = fnamemodify(fern_folder, ':p:~:.:h')
        return fern_folder
    endif

    return ''
endfunction

if !exists('g:airline_filetype_overrides')
    let g:airline_filetype_overrides = {}
endif

call extend(g:airline_filetype_overrides, {
            \ 'neo-tree':        ['NeoTree', '%{AirlineNeoTreeSource()}'],
            \ 'oil':             ['Oil', '%{AirlineOilFolder()}'],
            \ 'carbon.explorer': ['Carbon', '%{AirlineCarbonFolder()}'],
            \ 'fern':            ['%{AirlineFernMode()}', '%{AirlineFernFolder()}'],
            \ 'NvimTree':        ['NvimTree', ''],
            \ 'dirvish':         ['Dirvish', '%{expand("%:p:h")}'],
            \ 'molder':          ['Molder', '%{fnamemodify(b:molder_dir, ":p:~:.:h")}'],
            \ 'CHADTree':        ['CHADTree', ''],
            \ 'alpha':           ['Alpha', ''],
            \ })

" Show only mode, clipboard, paste and spell
let g:airline_section_a = airline#section#create_left([
            \ 'mode',
            \ 'clipboard',
            \ 'crypt',
            \ 'paste',
            \ 'keymap',
            \ 'spell',
            \ 'iminsert',
            \ ])

" Move filetype into other section
let g:airline_section_x = airline#section#create_right([
            \ 'tagbar',
            \ 'gutentags',
            \ 'gen_tags',
            \ 'grepper',
            \ ])

" Add filesize and filetype info
let g:airline_section_y = airline#section#create_right([
            \ 'indentation',
            \ 'ffenc',
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

" Disable vim-devicons integration for Airline's statusline
let g:webdevicons_enable_airline_statusline = 0

let s:airline_show_devicons = 0

if g:airline_show_devicons
    " Detect vim-devicons or nerdfont.vim
    " let s:has_devicons = exists('*WebDevIconsGetFileTypeSymbol') && exists('*WebDevIconsGetFileFormatSymbol')
    if findfile('autoload/nerdfont.vim', &rtp) != ''
        let s:airline_show_devicons = 1

        function! AirlineDevIconsStatus() abort
            if s:ActiveWindow() && !s:IsCompact()
                return nerdfont#find() . '  ' .  nerdfont#fileformat#find()
            endif
            return ''
        endfunction
    elseif findfile('plugin/webdevicons.vim', &rtp) != ''
        let s:airline_show_devicons = 1

        function! AirlineDevIconsStatus() abort
            if s:ActiveWindow() && !s:IsCompact()
                return WebDevIconsGetFileTypeSymbol() . '  ' . WebDevIconsGetFileFormatSymbol()
            endif
            return ''
        endfunction
    elseif exists("g:AirlineWebDevIconsFind")
        let s:airline_show_devicons = 1

        let s:web_devicons_fileformats = {
                    \ 'dos': '',
                    \ 'mac': '',
                    \ 'unix': '',
                    \ }

        function! AirlineDevIconsStatus() abort
            if s:ActiveWindow() && !s:IsCompact()
                return g:AirlineWebDevIconsFind(bufname('%')) . '  ' . get(s:web_devicons_fileformats, &fileformat, '')
            endif
            return ''
        endfunction
    endif
endif

if s:airline_show_devicons
    " Append DevIcons
    let g:airline_section_y .= '%( %{AirlineDevIconsStatus()} %)'
endif

if g:airline_show_vim_logo && s:airline_show_devicons
    " Show Vim Logo in Tabline
    let g:airline#extensions#tabline#tabs_label    = "\ue7c5" . ' '
    let g:airline#extensions#tabline#buffers_label = "\ue7c5" . ' '
endif

let g:airline_theme_map = extend(get(g:, 'airline_theme_map', {}), {
            \ 'gruvbox': 'gruvbox8',
            \ })

augroup AirlineSettings
    autocmd!
    autocmd User AirlineAfterInit call airline_settings#AfterInit()
augroup END
