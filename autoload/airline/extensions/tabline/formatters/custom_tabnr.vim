" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

function! airline#extensions#tabline#formatters#custom_tabnr#format(tab_nr_type, nr)
  return printf('%s[%s]', g:airline_symbols.space, a:nr)
endfunction
