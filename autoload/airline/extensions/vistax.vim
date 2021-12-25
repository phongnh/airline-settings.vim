scriptencoding utf-8

if !get(g:, 'loaded_vista', 0)
    finish
endif

function! airline#extensions#vistax#apply(...)
    if !exists('g:vista')
        return
    endif

    if &filetype == 'vista_kind' || &filetype == 'vista'
        let provider = get(g:vista, 'provider', '')
        call airline#extensions#apply_left_override('Vista', provider)
    endif
endfunction

function! airline#extensions#vistax#init(ext)
    call a:ext.add_statusline_func('airline#extensions#vistax#apply')
endfunction
