" https://github.com/SidOfc/carbon.nvim
function! airline_settings#carbon#Folder(...) abort
    if exists('b:carbon')
        return fnamemodify(b:carbon['path'], ':p:~:.:h')
    endif
    return ''
endfunction
