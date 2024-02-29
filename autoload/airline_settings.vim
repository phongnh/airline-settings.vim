function! airline_settings#AfterInit() abort
    setglobal showtabline=1 noshowmode

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
