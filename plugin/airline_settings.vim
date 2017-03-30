if exists('g:loaded_airline_settings')
    finish
endif
let g:loaded_airline_settings = 1

let g:airline_ignore_extensions = [
            \ 'anzu',   'bufferline', 'capslock',   'commandt',   'csv',        'eclim',
            \ 'hunks',  'netrw',      'obsession',  'po',         'promptline', 'syntastic',
            \ 'tagbar', 'tmuxline',   'whitespace', 'windowswap', 'wordcount',  'ycm',
            \ ]

for ext in g:airline_ignore_extensions
    let g:airline#extensions#{ext}#enabled = 0
endfor

let g:airline#extensions#tabline#enabled        = 1
let g:airline#extensions#tabline#tab_nr_type    = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnamemod       = ':t'

if exists("$POWERLINE") || get(g:, 'airline_settings_powerline', 0)
    let g:airline_powerline_fonts = 1
else
    let g:airline_powerline_fonts                 = 0
    let g:airline_left_sep                        = ''
    let g:airline_left_alt_sep                    = '|'
    let g:airline_right_sep                       = ''
    let g:airline_right_alt_sep                   = '|'
    let g:airline#extensions#tabline#left_sep     = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
endif

call airline#parts#define('clipboard', {
            \ 'function': 'AirlineClipboard',
            \ 'accent':   'bold',
            \ })

function! AirlineClipboard() abort
    return match(&clipboard, 'unnamed') > -1 ? '@' : ''
endfunction

" Show only mode, clipboard, paste and spell
let g:airline_section_a = airline#section#create_left(['mode', 'clipboard', 'paste', 'spell'])
" Show only filetype
let g:airline_section_x = airline#section#create_right(['filetype'])
" Hide percentage, linenr, maxlinenr and column
let g:airline_section_z = ''

augroup AirlineSettings
    autocmd!
    autocmd VimEnter * set showtabline=1 noshowmode
augroup END
