" https://github.com/mattn/vim-molder
function! airline_settings#molder#Folder(...) abort
    if exists('b:molder_dir')
        return fnamemodify(b:molder_dir, ':p:~:.:h')
    endif
    return ''
endfunction
