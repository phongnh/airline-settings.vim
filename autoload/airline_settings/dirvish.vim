" https://github.com/justinmk/vim-dirvish
function! airline_settings#dirvish#Folder(...) abort
    return fnamemodify(get(a:, 1, expand('%')), ':p:~:.:h')
endfunction
