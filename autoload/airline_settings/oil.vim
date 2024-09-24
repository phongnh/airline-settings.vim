" https://github.com/stevearc/oil.nvim
function! airline_settings#oil#Folder(...) abort
    let dir = ''
    let bufname = get(a:, 1, expand('%'))
    if bufname =~# '^oil://'
        let dir = substitute(bufname, '^oil://', '', '')
    elseif exists('b:oil_ready') && b:oil_ready
        let dir = luaeval('require("oil").get_current_dir()')
    endif
    return strlen(dir) ? fnamemodify(dir, ':p:~:.:h') : ''
endfunction
