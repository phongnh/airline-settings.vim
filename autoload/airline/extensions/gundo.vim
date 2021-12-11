scriptencoding utf-8

if !exists(':GundoToggle')
    finish
endif

function! airline#extensions#gundo#apply(...)
    if &ft == 'gundo'
        call airline#extensions#apply_left_override('Gundo', '')
    endif

    if &ft == 'diff' && bufname('%') == '__Gundo_Preview__'
        call airline#extensions#apply_left_override('Gundo Preview', '')
        " let w:airline_section_a = 'Gundo Preview'
        " let w:airline_section_b = ''
        " let w:airline_section_c = ''
        " let g:airline_section_y = ''
        " let w:airline_section_z = airline#section#create(['linenr', 'maxlinenr'])
    endif
endfunction

function! airline#extensions#gundo#init(ext)
    call a:ext.add_statusline_func('airline#extensions#gundo#apply')
endfunction
