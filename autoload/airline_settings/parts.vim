function! s:ClipboardStatus(...) abort
    return airline_settings#IsClipboardEnabled() ? g:airline_symbols.clipboard : ''
endfunction

function! s:SpellStatus(...) abort
    let spell = airline_settings#Trim(airline#parts#spell())
    return empty(spell) ? '' : (g:airline_symbols.space . spell)
endfunction

function! airline_settings#parts#Indentation(...) abort
    if airline_settings#IsInactive()
        return ''
    endif
    let l:shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    let compact = get(a:, 1, airline_settings#IsCompact())
    if compact
        return printf(&expandtab ? 'SPC: %d' : 'TAB: %d', l:shiftwidth)
    else
        return printf(&expandtab ? 'Spaces: %d' : 'Tab Size: %d', l:shiftwidth)
    endif
endfunction

function! airline_settings#parts#FileEncodingAndFormat() abort
    let l:encoding = strlen(&fileencoding) ? &fileencoding : &encoding
    let l:encoding = (l:encoding ==# 'utf-8') ? '' : l:encoding . ' '
    let l:bomb     = &bomb ? g:airline_symbols.bomb . ' ' : ''
    let l:noeol    = &eol ? '' : g:airline_symbols.noeol . ' '
    let l:format   = get(g:airline_symbols, &fileformat, '[empty]')
    let l:format   = (l:format ==# '[unix]') ? '' : l:format . ' '
    return l:encoding . l:bomb . l:noeol . l:format
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

function! airline_settings#parts#FileTypeIcon() abort
    return get(w:, 'airline_active', 1) ? airline_settings#devicons#FileType() : ''
endfunction
