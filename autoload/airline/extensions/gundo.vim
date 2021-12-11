scriptencoding utf-8

if !exists(':GundoToggle')
    finish
endif

function! airline#extensions#gundo#apply(...)
    if &ft == 'gundo'
        call airline#extensions#apply_left_override('undo', 'Gundo')
    endif

    if &ft == 'diff' && bufname(0) == '__Gundo_Preview__'
        call airline#extensions#apply_left_override('diff', 'Gundo Preview')
    endif
endfunction

function! airline#extensions#gundo#init(ext)
    call a:ext.add_statusline_func('airline#extensions#gundo#apply')
endfunction
