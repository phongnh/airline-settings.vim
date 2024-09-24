scriptencoding utf-8

function! airline#extensions#gv#apply(...)
    if &ft == 'GV'
        let w:airline_section_a = 'GV'
        let w:airline_section_b = join(['o: open split', 'O: open tab', 'gb: GBrowse', 'q: quit'], g:airline_symbols.space . g:airline_left_alt_sep . g:airline_symbols.space)
        let w:airline_section_c = ''
        let w:airline_section_x = ''
        let w:airline_section_y = ''
        let w:airline_section_z = airline#section#create(['lineinfo'])
    endif
endfunction

function! airline#extensions#gv#init(ext)
    call a:ext.add_statusline_func('airline#extensions#gv#apply')
endfunction
