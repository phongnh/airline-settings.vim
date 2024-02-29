" https://github.com/lambdalisue/fern.vim
function! s:ParseFernName(fern_name) abort
    return matchlist(a:fern_name, '^fern://\(.\+\)/file://\(.\+\)\$')
endfunction

function! airline_settings#fern#Mode(...) abort
    let data = s:ParseFernName(get(a:, 1, expand('%')))

    if len(data)
        let fern_mode = get(data, 1, '')
        if match(fern_mode, 'drawer') > -1
            return 'Drawer'
        endif
    endif

    return 'Fern'
endfunction

function! airline_settings#fern#Folder(...) abort
    let data = s:ParseFernName(get(a:, 1, expand('%')))

    if len(data)
        let fern_folder = get(data, 2, '')
        let fern_folder = substitute(fern_folder, ';\?\(#.\+\)\?\$\?$', '', '')
        let fern_folder = fnamemodify(fern_folder, ':p:~:.:h')
        return fern_folder
    endif

    return ''
endfunction
