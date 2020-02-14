if exists('g:loaded_airline_settings')
    finish
endif
let g:loaded_airline_settings = 1

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

if get(g:, 'airline_powerline', 0)
    let g:airline_powerline_fonts = 1
else
    let g:airline_powerline_fonts = 0
    let g:airline_left_sep        = ''
    let g:airline_left_alt_sep    = '|'
    let g:airline_right_sep       = ''
    let g:airline_right_alt_sep   = '|'

    let g:airline#extensions#tabline#left_sep     = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#close_symbol = '×'
endif

" Define extra parts
call airline#parts#define_function('clipboard', 'AirlineClipboardStatus')
call airline#parts#define_function('spaces', 'AirlineIndentationStatus')

function! AirlineClipboardStatus() abort
    return match(&clipboard, 'unnamed') > -1 ? 'ⓒ  ' : ''
endfunction

function! AirlineIndentationStatus() abort
    let l:shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    let compact = &spell || &paste
    if compact
        return printf(&expandtab ? 'SPC: %d' : 'TAB: %d', l:shiftwidth)
    else
        return printf(&expandtab ? 'Spaces: %d' : 'Tab Size: %d', l:shiftwidth)
    endif
endfunction

" Show only mode, clipboard, paste and spell
let g:airline_section_a = airline#section#create_left(['mode', 'clipboard', 'crypt', 'paste', 'keymap', 'spell', 'iminsert'])
" Show only filetype
let g:airline_section_x = airline#section#create_right(['gutentags', 'spaces', 'filetype'])
" Hide percentage, linenr, maxlinenr and column
let g:airline_section_z = ''

augroup AirlineSettings
    autocmd!
    autocmd VimEnter * set showtabline=1 noshowmode
augroup END
