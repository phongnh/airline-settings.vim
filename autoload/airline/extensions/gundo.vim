scriptencoding utf-8

if !exists(':GundoToggle') || !exists(':MundoToggle')
    finish
endif

function! airline#extensions#gundo#apply(...)
    if &ft == 'gundo'
        call airline#extensions#apply_left_override('Gundo', '')
        return
    endif

    if &ft == 'diff' && bufname('%') == '__Gundo_Preview__'
        call airline#extensions#apply_left_override('Gundo Preview', '')
        " let w:airline_section_a = 'Gundo Preview'
        " let w:airline_section_b = ''
        " let w:airline_section_c = ''
        " let g:airline_section_y = ''
        " let w:airline_section_z = airline#section#create(['linenr', 'maxlinenr'])
        return
    endif

    if &ft == 'Mundo'
        call airline#extensions#apply_left_override('Mundo', '')
        return
    endif

    if &ft == 'MundoDiff' && bufname('%') == '__Mundo_Preview__'
        call airline#extensions#apply_left_override('Mundo Preview', '')
        return
    endif
endfunction

function! airline#extensions#gundo#init(ext)
    call a:ext.add_statusline_func('airline#extensions#gundo#apply')
endfunction
