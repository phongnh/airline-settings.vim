function! airline_settings#Strip(str) abort
    return substitute(a:str, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

if exists('*trim')
    function! airline_settings#Strip(str) abort
        return trim(a:str)
    endfunction
endif

function! airline_settings#IsClipboardEnabled() abort
    return match(&clipboard, 'unnamed') > -1
endfunction

function! airline_settings#IsCompact() abort
    return &spell || &paste || airline_settings#IsClipboardEnabled() || winwidth(0) <= g:airline_winwidth_config.xsmall
endfunction

function! airline_settings#AfterInit() abort
    setglobal showtabline=1 noshowmode

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

    if get(g:, 'airline_show_linenr', 0)
        call airline#parts#define('lineinfo', {
                    \ 'raw':    '%4l:%-3v %P',
                    \ 'accent': 'bold',
                    \ })
        let g:airline_section_z = airline#section#create(['lineinfo'])
    else
        " Hide percentage, linenr, maxlinenr and column
        let g:airline_section_z = ''
    endif
endfunction
