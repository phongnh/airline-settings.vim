function! s:ClipboardStatus(...) abort
    return airline_settings#IsClipboardEnabled() ? g:airline_symbols.clipboard : ''
endfunction

function! s:SpellStatus(...) abort
    if g:airline_detect_spelllang ==# 'flag'
        let spell = airline_settings#Trim(airline#parts#spell())
        return empty(spell) ? '' : (g:airline_symbols.space . spell)
    endif
    return &spell ? toupper(substitute(&spelllang, ',', '/', 'g')) : ''
endfunction

function! airline_settings#parts#Status() abort
    if get(w:, 'airline_active', 0)
        return airline_settings#Concatenate([
                    \ s:ClipboardStatus(),
                    \ airline#parts#paste(),
                    \ s:SpellStatus(),
                    \ ], 0)
    endif
    return ''
endfunction

function! s:IndentationStatus(...) abort
    let l:shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    let compact = get(a:, 1, airline_settings#IsCompact())
    if compact
        return printf(&expandtab ? 'SPC: %d' : 'TAB: %d', l:shiftwidth)
    else
        return printf(&expandtab ? 'Spaces: %d' : 'Tab Size: %d', l:shiftwidth)
    endif
endfunction

function! s:FileEncodingAndFormatStatus() abort
    let l:encoding = strlen(&fileencoding) ? &fileencoding : &encoding
    let l:encoding = (l:encoding ==# 'utf-8') ? '' : l:encoding . ' '
    let l:bomb     = &bomb ? g:airline_symbols.bomb . ' ' : ''
    let l:noeol    = &eol ? '' : g:airline_symbols.noeol . ' '
    let l:format   = get(g:airline_symbols, &fileformat, '[empty]')
    let l:format   = (l:format ==# '[unix]') ? '' : l:format . ' '
    return l:encoding . l:bomb . l:noeol . l:format
endfunction

function! airline_settings#parts#Settings(...) abort
    if get(w:, 'airline_active', 0)
        return airline_settings#Concatenate([
                    \ s:IndentationStatus(),
                    \ s:FileEncodingAndFormatStatus(),
                    \ ], 1)
    endif
    return ''
endfunction

function! airline_settings#parts#FileType(...) abort
    if get(w:, 'airline_active', 0)
        return airline_settings#BufferType() . airline_settings#devicons#FileType(expand('%'))
    endif
    return ''
endfunction
