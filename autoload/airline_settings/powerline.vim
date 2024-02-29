function! s:InitPowerlineStyles() abort
    if exists('g:airline_separator_styles')
        return
    endif

    let g:airline_separator_styles = {
                \ '><': { 'left': "\ue0b0", 'right': "\ue0b2" },
                \ '>(': { 'left': "\ue0b0", 'right': "\ue0b6" },
                \ '>\': { 'left': "\ue0b0", 'right': "\ue0be" },
                \ '>/': { 'left': "\ue0b0", 'right': "\ue0ba" },
                \ ')(': { 'left': "\ue0b4", 'right': "\ue0b6" },
                \ ')<': { 'left': "\ue0b4", 'right': "\ue0b2" },
                \ ')\': { 'left': "\ue0b4", 'right': "\ue0be" },
                \ ')/': { 'left': "\ue0b4", 'right': "\ue0ba" },
                \ '\\': { 'left': "\ue0b8", 'right': "\ue0be" },
                \ '\/': { 'left': "\ue0b8", 'right': "\ue0ba" },
                \ '\<': { 'left': "\ue0b8", 'right': "\ue0b2" },
                \ '\(': { 'left': "\ue0b8", 'right': "\ue0b6" },
                \ '//': { 'left': "\ue0bc", 'right': "\ue0ba" },
                \ '/\': { 'left': "\ue0bc", 'right': "\ue0be" },
                \ '/<': { 'left': "\ue0bc", 'right': "\ue0b2" },
                \ '/(': { 'left': "\ue0bc", 'right': "\ue0b6" },
                \ '||': { 'left': '', 'right': '' },
                \ }

    let g:airline_subseparator_styles = {
                \ '><': { 'left': "\ue0b1", 'right': "\ue0b3" },
                \ '>(': { 'left': "\ue0b1", 'right': "\ue0b7" },
                \ '>\': { 'left': "\ue0b1", 'right': "\ue0b9" },
                \ '>/': { 'left': "\ue0b1", 'right': "\ue0bb" },
                \ ')(': { 'left': "\ue0b5", 'right': "\ue0b7" },
                \ ')<': { 'left': "\ue0b5", 'right': "\ue0b1" },
                \ ')\': { 'left': "\ue0b5", 'right': "\ue0b9" },
                \ ')/': { 'left': "\ue0b5", 'right': "\ue0bb" },
                \ '\\': { 'left': "\ue0b9", 'right': "\ue0b9" },
                \ '\/': { 'left': "\ue0b9", 'right': "\ue0bb" },
                \ '\<': { 'left': "\ue0b9", 'right': "\ue0b3" },
                \ '\(': { 'left': "\ue0b9", 'right': "\ue0b7" },
                \ '//': { 'left': "\ue0bb", 'right': "\ue0bb" },
                \ '/\': { 'left': "\ue0bd", 'right': "\ue0b9" },
                \ '/<': { 'left': "\ue0bb", 'right': "\ue0b3" },
                \ '/(': { 'left': "\ue0bb", 'right': "\ue0b7" },
                \ '||': { 'left': '|', 'right': '|' },
                \ }

    call extend(g:airline_separator_styles, {
                \ 'default': copy(g:airline_separator_styles['><']),
                \ 'angle':   copy(g:airline_separator_styles['><']),
                \ 'curvy':   copy(g:airline_separator_styles[')(']),
                \ 'slant':   copy(g:airline_separator_styles['//']),
                \ })

    call extend(g:airline_subseparator_styles, {
                \ 'default': copy(g:airline_subseparator_styles['><']),
                \ 'angle':   copy(g:airline_subseparator_styles['><']),
                \ 'curvy':   copy(g:airline_subseparator_styles[')(']),
                \ 'slant':   copy(g:airline_subseparator_styles['//']),
                \ })
endfunction

function! s:Rand() abort
    return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
endfunction

function! s:GetStyle(style) abort
    let l:style = 'default'

    if type(a:style) == v:t_string && strlen(a:style)
        let l:style = a:style
    endif

    if l:style ==? 'random'
        let l:rand = str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
        let l:style = keys(g:airline_separator_styles)[l:rand % len(g:airline_separator_styles)]
    endif

    return l:style
endfunction

function! s:SetStatuslineSeparators(style) abort
    let l:style = s:GetStyle(a:style)

    let l:separator    = get(g:airline_separator_styles, l:style, g:airline_separator_styles['default'])
    let l:subseparator = get(g:airline_subseparator_styles, l:style, g:airline_subseparator_styles['default'])

    let g:airline_left_sep      = l:separator['left']
    let g:airline_right_sep     = l:separator['right']
    let g:airline_left_alt_sep  = l:subseparator['left']
    let g:airline_right_alt_sep = l:subseparator['right']
endfunction

function! s:SetTablineSeparators(style) abort
    let l:style = s:GetStyle(a:style)

    let l:separator    = get(g:airline_separator_styles, l:style, g:airline_separator_styles['default'])
    let l:subseparator = get(g:airline_subseparator_styles, l:style, g:airline_subseparator_styles['default'])

    let g:airline#extensions#tabline#left_sep      = l:separator['left']
    let g:airline#extensions#tabline#right_sep     = l:separator['right']
    let g:airline#extensions#tabline#left_alt_sep  = l:subseparator['left']
    let g:airline#extensions#tabline#right_alt_sep = l:subseparator['right']
endfunction

function! airline_settings#powerline#SetSeparators(style, ...) abort
    call s:InitPowerlineStyles()
    call s:SetStatuslineSeparators(a:style)
    call s:SetTablineSeparators(get(a:, 1, a:style))
endfunction
