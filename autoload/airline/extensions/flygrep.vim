scriptencoding utf-8

if !exists(':FlyGrep')
    finish
endif

function! airline#extensions#flygrep#apply(...)
    if &ft == 'SpaceVimFlyGrep'
        let w:airline_section_a = 'FlyGrep'
        let w:airline_section_b = '%{SpaceVim#plugins#flygrep#mode()}'
        let w:airline_section_c = '%{fnamemodify(getcwd(), ":~")}'
        let w:airline_section_x = '%{SpaceVim#plugins#flygrep#lineNr()}'
        let w:airline_section_y = ''
        let w:airline_section_z = ''
    endif
endfunction

function! airline#extensions#flygrep#init(ext)
    call a:ext.add_statusline_func('airline#extensions#flygrep#apply')
endfunction
