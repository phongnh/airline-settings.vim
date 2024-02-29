" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

function! airline#extensions#tabline#formatters#simple#format(tab_nr, buflist)
    return printf('%s%s:', g:airline_symbols.space, a:tab_nr)
endfunction
