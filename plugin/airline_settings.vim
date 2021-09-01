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
            \ 'hunks',
            \ 'keymap',
            \ 'localsearch',
            \ 'netrw',
            \ 'obsession',
            \ 'omnisharp',
            \ 'po',
            \ 'poetv',
            \ 'promptline',
            \ 'scrollbar',
            \ 'searchcount',
            \ 'tmuxline',
            \ 'unicode',
            \ 'unite',
            \ 'vimagit',
            \ 'vimcmake',
            \ 'vimtex',
            \ 'virtualenv',
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
let g:airline_symbols.clipboard  = '🅒 '
let g:airline_symbols.paste      = '🅟 '
let g:airline_symbols.spell      = '🅢 '
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.dirty      = ''

" vim-devicons or nerdfont.vim support
let g:airline_show_devicons = get(g:, 'airline_show_devicons', 1)

" Show Vim Logo in Tabline
let g:airline_show_vim_logo = get(g:, 'airline_show_vim_logo', 1)

" Powerline Fonts
let g:airline_powerline_fonts  = get(g:, 'airline_powerline', 0)
let g:airline_powerline_style  = get(g:, 'airline_powerline_style', 'default')
let g:airline_powerline_spaces = extend({ 'left': 0, 'left_alt': 0, 'right': 0, 'right_alt':0 }, get(g:, 'airline_powerline_spaces', {}))

if g:airline_powerline_fonts
    let s:powerline_separator_styles = {
                \ 'default':     { 'left': "\ue0b0", 'right': "\ue0b2" },
                \ 'curvy':       { 'left': "\ue0b4", 'right': "\ue0b6" },
                \ 'slant1':      { 'left': "\ue0b8", 'right': "\ue0be" },
                \ 'slant2':      { 'left': "\ue0bc", 'right': "\ue0ba" },
                \ 'slant3':      { 'left': "\ue0b8", 'right': "\ue0ba" },
                \ 'slant4':      { 'left': "\ue0bc", 'right': "\ue0be" },
                \ 'slant-left':  { 'left': "\ue0b8", 'right': "\ue0be" },
                \ 'slant-right': { 'left': "\ue0bc", 'right': "\ue0ba" },
                \ 'slant-curvy': { 'left': "\ue0b8", 'right': "\ue0b6" },
                \ 'angly1':      { 'left': "\ue0b8", 'right': "\ue0be" },
                \ 'angly2':      { 'left': "\ue0bc", 'right': "\ue0ba" },
                \ 'angly3':      { 'left': "\ue0b8", 'right': "\ue0ba" },
                \ 'angly4':      { 'left': "\ue0bc", 'right': "\ue0be" },
                \ 'angly-left':  { 'left': "\ue0b8", 'right': "\ue0be" },
                \ 'angly-right': { 'left': "\ue0bc", 'right': "\ue0ba" },
                \ }

    let s:powerline_tabline_separator_styles = extend(deepcopy(s:powerline_separator_styles), {
                \ 'slant1': copy(s:powerline_separator_styles['slant2']),
                \ 'slant2': copy(s:powerline_separator_styles['slant1']),
                \ 'slant3': copy(s:powerline_separator_styles['slant4']),
                \ 'slant4': copy(s:powerline_separator_styles['slant3']),
                \ 'angly1': copy(s:powerline_separator_styles['angly2']),
                \ 'angly2': copy(s:powerline_separator_styles['angly1']),
                \ 'angly3': copy(s:powerline_separator_styles['angly4']),
                \ 'angly4': copy(s:powerline_separator_styles['angly3']),
                \ })

    let s:powerline_subseparator_styles = {
                \ 'default':     { 'left': "\ue0b1", 'right': "\ue0b3" },
                \ 'curvy':       { 'left': "\ue0b5", 'right': "\ue0b7" },
                \ 'slant1':      { 'left': "\ue0b9", 'right': "\ue0b9" },
                \ 'slant2':      { 'left': "\ue0bb", 'right': "\ue0bb" },
                \ 'slant3':      { 'left': "\ue0b9", 'right': "\ue0bb" },
                \ 'slant4':      { 'left': "\ue0bd", 'right': "\ue0b9" },
                \ 'slant-left':  { 'left': "\ue0b9", 'right': "\ue0b9" },
                \ 'slant-right': { 'left': "\ue0bb", 'right': "\ue0bb" },
                \ 'slant-curvy': { 'left': "\ue0b9", 'right': "\ue0b7" },
                \ 'angly1':      { 'left': "\ue0b9", 'right': "\ue0b9" },
                \ 'angly2':      { 'left': "\ue0bb", 'right': "\ue0bb" },
                \ 'angly3':      { 'left': "\ue0b9", 'right': "\ue0bb" },
                \ 'angly4':      { 'left': "\ue0bd", 'right': "\ue0b9" },
                \ 'angly-left':  { 'left': "\ue0b9", 'right': "\ue0b9" },
                \ 'angly-right': { 'left': "\ue0bb", 'right': "\ue0bb" },
                \ }

    let s:powerline_tabline_subseparator_styles = extend(deepcopy(s:powerline_subseparator_styles), {
                \ 'slant1': copy(s:powerline_subseparator_styles['slant2']),
                \ 'slant2': copy(s:powerline_subseparator_styles['slant1']),
                \ 'slant3': copy(s:powerline_subseparator_styles['slant4']),
                \ 'slant4': copy(s:powerline_subseparator_styles['slant3']),
                \ 'angly1': copy(s:powerline_subseparator_styles['angly2']),
                \ 'angly2': copy(s:powerline_subseparator_styles['angly1']),
                \ 'angly3': copy(s:powerline_subseparator_styles['angly4']),
                \ 'angly4': copy(s:powerline_subseparator_styles['angly3']),
                \ })

    function! s:Rand() abort
        return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
    endfunction

    function! s:GetSeparator(style, separator_styles, subseparator_styles, spaces) abort
        let l:separator    = copy(get(a:separator_styles, a:style, a:separator_styles['default']))
        let l:subseparator = copy(get(a:subseparator_styles, a:style, a:subseparator_styles['default']))

        let l:separator['left']     .= repeat(' ', a:spaces['left'])
        let l:separator['right']    .= repeat(' ', a:spaces['right'])
        let l:subseparator['left']  .= repeat(' ', a:spaces['left_alt'])
        let l:subseparator['right'] .= repeat(' ', a:spaces['right_alt'])

        return [l:separator, l:subseparator]
    endfunction

    function! s:SetSeparator(style, spaces) abort
        let l:style = a:style
        if l:style ==? 'random'
            let l:style = keys(s:powerline_separator_styles)[s:Rand() % len(s:powerline_separator_styles)]
        endif

        let [l:separator, l:subseparator] = s:GetSeparator(
                    \ l:style,
                    \ s:powerline_separator_styles,
                    \ s:powerline_subseparator_styles,
                    \ a:spaces)

        let g:airline_left_sep      = l:separator['left']
        let g:airline_right_sep     = l:separator['right']
        let g:airline_left_alt_sep  = l:subseparator['left']
        let g:airline_right_alt_sep = l:subseparator['right']

        let [l:tabline_separator, l:tabline_subseparator] = s:GetSeparator(
                    \ l:style,
                    \ s:powerline_tabline_separator_styles,
                    \ s:powerline_tabline_subseparator_styles,
                    \ a:spaces)

        let g:airline#extensions#tabline#left_sep      = l:tabline_separator['left']
        let g:airline#extensions#tabline#right_sep     = l:tabline_separator['right']
        let g:airline#extensions#tabline#left_alt_sep  = l:tabline_subseparator['left']
        let g:airline#extensions#tabline#right_alt_sep = l:tabline_subseparator['right']
    endfunction

    call s:SetSeparator(g:airline_powerline_style, g:airline_powerline_spaces)
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

let g:airline_filetype_overrides['fern'] = ['%{AirlineFernMode()}', '%{AirlineFernFolder()}']
let g:airline_filetype_overrides['NvimTree'] = ['NvimTree', '']
let g:airline_filetype_overrides['dirvish'] = ['Dirvish', '%{expand("%:p:h")}']

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
            \ 'gen_tags',
            \ 'grepper',
            \ ])

" Add filesize and filetype info
let g:airline_section_y = airline#section#create_right([
            \ 'indentation',
            \ 'ffenc',
            \ 'filetype',
            \ ])


let g:airline_section_error   = airline#section#create([
            \ 'ycm_error_count',
            \ 'syntastic-err',
            \ 'neomake_error_count',
            \ 'ale_error_count',
            \ 'lsp_error_count',
            \ 'nvimlsp_error_count',
            \ 'languageclient_error_count',
            \ 'coc_error_count',
            \ ])
let g:airline_section_warning = airline#section#create([
            \ 'ycm_warning_count',
            \ 'syntastic-warn',
            \ 'neomake_warning_count',
            \ 'ale_warning_count',
            \ 'lsp_warning_count',
            \ 'nvimlsp_warning_count',
            \ 'languageclient_warning_count',
            \ 'coc_warning_count',
            \ 'whitespace',
            \ ])

" Disable vim-devicons integration for Airline's statusline
let g:webdevicons_enable_airline_statusline = 0

" Detect vim-devicons or nerdfont.vim
let s:has_devicons = findfile('plugin/webdevicons.vim', &rtp) != ''
" let s:has_devicons = exists('*WebDevIconsGetFileTypeSymbol') && exists('*WebDevIconsGetFileFormatSymbol')
let s:has_nerdfont = findfile('autoload/nerdfont.vim', &rtp) != ''

let s:airline_show_devicons = 0

if g:airline_show_devicons && s:has_nerdfont
    let s:airline_show_devicons = 1

    function! AirlineDevIconsStatus() abort
        if s:ActiveWindow() && !s:IsCompact()
            return nerdfont#find() . '  ' .  nerdfont#fileformat#find()
        endif
        return ''
    endfunction
elseif g:airline_show_devicons && s:has_devicons
    let s:airline_show_devicons = 1

    function! AirlineDevIconsStatus() abort
        if s:ActiveWindow() && !s:IsCompact()
            return WebDevIconsGetFileTypeSymbol() . '  ' . WebDevIconsGetFileFormatSymbol()
        endif
        return ''
    endfunction
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

" Overwrite for Terminal
call airline#parts#define('linenr', {
            \ 'raw': '%l',
            \ 'accent': 'bold',
            \ })

" Overwrite for Terminal
call airline#parts#define('maxlinenr', {
            \ 'raw': '/%L',
            \ 'accent': 'bold',
            \ })

function! s:SetupSectionZ() abort
    if get(g:, 'airline_show_linenr', 0)
        call airline#parts#define('lineinfo', {
                    \ 'raw': '%4l:%-3v %P',
                    \ 'accent': 'bold',
                    \ })
        let g:airline_section_z = airline#section#create(['lineinfo'])
    else
        " Hide percentage, linenr, maxlinenr and column
        let g:airline_section_z = ''
    endif
endfunction

augroup AirlineSettings
    autocmd!
    autocmd User AirlineAfterInit setglobal showtabline=1 noshowmode
    autocmd User AirlineAfterInit call <SID>SetupSectionZ()
augroup END
