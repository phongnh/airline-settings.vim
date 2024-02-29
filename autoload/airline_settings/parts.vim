function! s:ClipboardStatus(...) abort
    return airline_settings#IsClipboardEnabled() ? g:airline_symbols.clipboard : ''
endfunction

function! s:SpellStatus(...) abort
    let spell = airline_settings#Strip(airline#parts#spell())
    return empty(spell) ? '' : (g:airline_symbols.space . spell)
endfunction

function! airline_settings#parts#Indentation() abort
    if !get(w:, 'airline_active', 1) || winwidth(0) < g:airline_winwidth_config.small
        return ''
    endif

    let l:shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    if airline_settings#IsCompact()
        return printf(&expandtab ? 'SPC: %d' : 'TAB: %d', l:shiftwidth)
    else
        return printf(&expandtab ? 'Spaces: %d' : 'Tab Size: %d', l:shiftwidth)
    endif
endfunction

function! airline_settings#parts#FileEncodingAndFormat() abort
    let l:encoding = strlen(&fileencoding) ? &fileencoding : &encoding
    let l:bomb     = &bomb ? '[BOM]' : ''
    let l:format   = strlen(&fileformat) ? printf('[%s]', &fileformat) : ''

    " Skip common string utf-8[unix]
    if (l:encoding . l:format) ==# g:airline#parts#ffenc#skip_expected_string
        return l:bomb
    endif

    return l:encoding . l:bomb . l:format
endfunction

function! airline_settings#parts#Settings() abort
    let spc = g:airline_symbols.space
    let parts = [
                \ s:ClipboardStatus(),
                \ airline#parts#paste(),
                \ s:SpellStatus(),
                \ ]
    return join(filter(copy(parts), '!empty(v:val)'), spc . g:airline_left_alt_sep . spc)
endfunction
