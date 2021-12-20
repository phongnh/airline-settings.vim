scriptencoding utf-8

if !exists(':Vista')
    finish
endif

function! airline#extensions#vista#apply(...)
    if !exists('g:vista')
        return
    endif

    let fname = get(g:vista.source, 'fname', '')
    let provider = get(g:vista, 'provider', '')

    if &filetype == 'vista_kind' || &filetype == 'vista'
        call airline#extensions#apply_left_override(empty(provider) ? 'Vista' : provider, '')

        if fname != '__vista__'
            let fpath = get(g:vista.source, 'fpath', '')
            let w:airline_section_c = fnamemodify(fpath, ':t')
        endif
    endif
endfunction

function! airline#extensions#vista#init(ext)
    call a:ext.add_statusline_func('airline#extensions#vista#apply')
endfunction
