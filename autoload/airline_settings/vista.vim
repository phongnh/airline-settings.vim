function! airline_settings#vista#Mode() abort
    if !exists('g:vista')
        return ''
    endif
    return get(g:vista, 'provider', '')
endfunction
