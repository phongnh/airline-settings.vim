" https://github.com/stevearc/oil.nvim
function! airline_settings#oil#Folder(...) abort
    let l:oil_dir = get(a:, 1, expand('%'))
    if l:oil_dir =~# '^oil://'
        let l:oil_dir = substitute(l:oil_dir, '^oil://', '', '')
        return fnamemodify(l:oil_dir, ':p:~:.:h')
    endif
    return ''
endfunction
