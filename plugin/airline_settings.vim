if exists('g:loaded_airline_settings')
    finish
endif
let g:loaded_airline_settings = 1

" Window width
let s:xsmall_window_width = 60
let s:small_window_width  = 80

" Disable some extensions
let g:airline_ignore_extensions = [
            \ 'bufferline',
            \ 'capslock',
            \ 'commandt',
            \ 'csv',
            \ 'ctrlspace',
            \ 'cursormode',
            \ 'denite',
            \ 'eclim',
            \ 'example',
            \ 'fern',
            \ 'hunks',
            \ 'localsearch',
            \ 'netrw',
            \ 'obsession',
            \ 'po',
            \ 'promptline',
            \ 'tmuxline',
            \ 'unite',
            \ 'vimagit',
            \ 'vimtex',
            \ 'virtualenv',
            \ 'vista',
            \ 'whitespace',
            \ 'windowswap',
            \ 'wordcount',
            \ 'xkblayout',
            \ ]

for ext in g:airline_ignore_extensions
    let g:airline#extensions#{ext}#enabled = 0
endfor

" Disable truncation
let g:airline#extensions#default#section_truncate_width = {}

" Enable iminsert
let g:airline_detect_iminsert = 1

" Enable tabline
let g:airline#extensions#tabline#enabled         = 1
let g:airline#extensions#tabline#show_splits     = 0
let g:airline#extensions#tabline#show_tab_count  = 0
let g:airline#extensions#tabline#tab_nr_type     = 2
let g:airline#extensions#tabline#tabnr_formatter = 'custom_tabnr'
let g:airline#extensions#tabline#tabs_label      = 'Tabs'
let g:airline#extensions#tabline#buffers_label   = 'Buffers'
let g:airline#extensions#tabline#buffer_nr_show  = 1
let g:airline#extensions#tabline#fnamemod        = ':t'
let g:airline#extensions#tabline#fnametruncate   = 30

" Branch - show only 30 characters of branch name
let g:airline#extensions#branch#displayed_head_limit = 30

" Don't show 'utf-8[unix]'
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'

" Symbols: https://en.wikipedia.org/wiki/Enclosed_Alphanumerics
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.clipboard  = '🅒 '
let g:airline_symbols.paste      = '🅟 '
let g:airline_symbols.spell      = '🅢 '
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.dirty      = ''

" Powerline Fonts
let g:airline_powerline_fonts  = get(g:, 'airline_powerline', 0)
let g:airline_powerline_style  = get(g:, 'airline_powerline_style', 'default')
let g:airline_powerline_spaces = extend({ 'left': 0, 'left_alt': 0, 'right': 0, 'right_alt':0 }, get(g:, 'airline_powerline_spaces', {}))

if g:airline_powerline_fonts
    let g:airline_left_alt_sep  = ''
    let g:airline_right_alt_sep = ''

    if g:airline_powerline_style ==? 'curvy'
        let g:airline_left_sep      = "\ue0b4"
        let g:airline_left_alt_sep  = "\ue0b5"
        let g:airline_right_sep     = "\ue0b6"
        let g:airline_right_alt_sep = "\ue0b7"
    elseif g:airline_powerline_style ==? 'angly1'
        let g:airline_left_sep      = "\ue0b8"
        let g:airline_left_alt_sep  = "\ue0b9"
        let g:airline_right_sep     = "\ue0ba"
        let g:airline_right_alt_sep = "\ue0bb"
    elseif g:airline_powerline_style ==? 'angly2'
        let g:airline_left_sep      = "\ue0bc"
        let g:airline_left_alt_sep  = "\ue0bd"
        let g:airline_right_sep     = "\ue0be"
        let g:airline_right_alt_sep = "\ue0bf"
    elseif g:airline_powerline_style ==? 'angly-mixed1'
        let g:airline_left_sep      = "\ue0b8"
        let g:airline_left_alt_sep  = "\ue0b9"
        let g:airline_right_sep     = "\ue0be"
        let g:airline_right_alt_sep = "\ue0bf"
    elseif g:airline_powerline_style ==? 'angly-mixed2'
        let g:airline_left_sep      = "\ue0b8"
        let g:airline_left_alt_sep  = "\ue0b9"
        let g:airline_right_sep     = "\ue0ba"
        let g:airline_right_alt_sep = "\ue0bb"
    elseif g:airline_powerline_style ==? 'flames' || g:airline_powerline_style ==? 'flamey'
        let g:airline_left_sep      = "\ue0c0"
        let g:airline_left_alt_sep  = "\ue0c1"
        let g:airline_right_sep     = "\ue0c2"
        let g:airline_right_alt_sep = "\ue0c3"
    elseif g:airline_powerline_style ==? 'pixelated-blocks1' || g:airline_powerline_style ==? 'pixey1'
        let g:airline_left_sep  = "\ue0c4"
        let g:airline_right_sep = "\ue0c5"
    elseif g:airline_powerline_style ==? 'pixelated-blocks2' || g:airline_powerline_style ==? 'pixey2'
        let g:airline_left_sep  = "\ue0c6"
        let g:airline_right_sep = "\ue0c7"
    elseif g:airline_powerline_style ==? 'sun'
        let g:airline_left_sep  = "\ue0c8"
        let g:airline_right_sep = "\ue0ca"
    elseif g:airline_powerline_style ==? 'custom'
        let g:airline_left_sep      = "\ue0cc"
        let g:airline_left_alt_sep  = "\ue0cd"
        let g:airline_right_sep     = "\ue0d0"
        let g:airline_right_alt_sep = "\ue0d0"
    elseif g:airline_powerline_style ==? 'lego' || g:airline_powerline_style ==? 'blocky'
        let g:airline_left_sep  = "\ue0d1"
        let g:airline_right_sep = "\ue0d0"
    else
        let g:airline_left_sep      = "\ue0b0"
        let g:airline_left_alt_sep  = "\ue0b1"
        let g:airline_right_sep     = "\ue0b2"
        let g:airline_right_alt_sep = "\ue0b3"
    endif

    let g:airline_left_sep      .= repeat(' ', g:airline_powerline_spaces['left'])
    let g:airline_left_alt_sep  .= repeat(' ', g:airline_powerline_spaces['left_alt'])
    let g:airline_right_sep     .= repeat(' ', g:airline_powerline_spaces['right'])
    let g:airline_right_alt_sep .= repeat(' ', g:airline_powerline_spaces['right_alt'])
else
    let g:airline_powerline_fonts = 0
    let g:airline_left_sep        = ''
    let g:airline_left_alt_sep    = '|'
    let g:airline_right_sep       = ''
    let g:airline_right_alt_sep   = '|'

    let g:airline#extensions#tabline#left_sep     = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#close_symbol = '×'

    let g:airline_symbols.clipboard .= ' '
    let g:airline_symbols.branch     = ''
endif

" Define extra parts
call airline#parts#define_function('clipboard', 'AirlineClipboardStatus')
call airline#parts#define_function('indentation', 'AirlineIndentationStatus')
call airline#parts#define_function('ffenc', 'AirlineFileEncodingAndFormatStatus')

function! AirlineClipboardStatus() abort
    return match(&clipboard, 'unnamed') > -1 ? g:airline_symbols.clipboard : ''
endfunction

function! s:ActiveWindow() abort
    return get(w:, 'airline_active', 1)
endfunction

function! s:IsCompact() abort
    return &spell || &paste || strlen(AirlineClipboardStatus()) || winwidth(0) <= s:xsmall_window_width
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
        let fern_folder = substitute(fern_folder, ';\?\(#.\+\)\?$', '', '')
        let fern_folder = fnamemodify(fern_folder, ':p:~:.:h')
        return fern_folder
    endif

    return ''
endfunction

if !exists('g:airline_filetype_overrides')
    let g:airline_filetype_overrides = {}
endif

let g:airline_filetype_overrides['fern'] = ['%{AirlineFernMode()}', '%{AirlineFernFolder()}']

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
            \ 'vista',
            \ 'gutentags',
            \ 'grepper',
            \ ])

" Add filesize and filetype info
let g:airline_section_y = airline#section#create_right([
            \ 'indentation',
            \ 'ffenc',
            \ 'filetype',
            \ ])


let g:airline_section_error   = airline#section#create([
            \ 'syntastic-err',
            \ 'ale_error_count',
            \ 'coc_error_count',
            \ ])
let g:airline_section_warning = airline#section#create([
            \ 'syntastic-warn',
            \ 'ale_warning_count',
            \ 'coc_warning_count',
            \ 'whitespace',
            \ ])

" Disable vim-devicons integration for Airline's statusline
let g:webdevicons_enable_airline_statusline = 0

" Detect DevIcons
let s:has_devicons = findfile('plugin/webdevicons.vim', &rtp) != ''
" let s:has_devicons = exists('*WebDevIconsGetFileTypeSymbol') && exists('*WebDevIconsGetFileFormatSymbol')

if s:has_devicons
    function! AirlineWebDevIconsStatus() abort
        if s:ActiveWindow() && !s:IsCompact()
            return WebDevIconsGetFileTypeSymbol() . '  ' . WebDevIconsGetFileFormatSymbol()
        endif
        return ''
    endfunction

    " Append WebDevIcons
    let g:airline_section_y .= '%( %{AirlineWebDevIconsStatus()} %)'
endif

function! s:SetupSectionZ() abort
    if get(g:, 'airline_show_linenr', 0)
        let spc = g:airline_symbols.space
        let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr', spc . ':%3v'])
    else
        " Hide percentage, linenr, maxlinenr and column
        let g:airline_section_z = ''
        " FIXME: Hack to disable airline_section_z on Terminal
        call airline#parts#define_text('linenr', '')
        call airline#parts#define_text('maxlinenr', '')
    endif
endfunction

augroup AirlineSettings
    autocmd!
    autocmd User AirlineAfterInit setglobal showtabline=1 noshowmode
    autocmd User AirlineAfterInit call <SID>SetupSectionZ()
augroup END
