scriptencoding utf-8

function! airline#extensions#gitcommit#apply(...)
    if &ft == 'gitcommit'
        call airline#parts#define_text('gitcommit', 'Commit Message')
        let w:airline_section_a = airline#section#create_left([
                    \ 'gitcommit',
                    \ 'status',
                    \ ])
        let w:airline_section_b = airline#section#create(['branch'])
        let w:airline_section_c = ''
        let w:airline_section_x = ''
        let w:airline_section_y = ''
        let w:airline_section_z = airline#section#create(['lineinfo'])
    endif
endfunction

function! airline#extensions#gitcommit#init(ext)
    call a:ext.add_statusline_func('airline#extensions#gitcommit#apply')
endfunction
