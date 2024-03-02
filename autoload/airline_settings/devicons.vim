function! airline_settings#devicons#FileType(...) abort
    return ''
endfunction

function! airline_settings#devicons#Detect() abort
    if findfile('autoload/nerdfont.vim', &rtp) != ''
        function! airline_settings#devicons#FileType(...) abort
            return g:airline_symbols.space . nerdfont#find() . g:airline_symbols.space
        endfunction

        return 1
    elseif findfile('plugin/webdevicons.vim', &rtp) != ''
        function! airline_settings#devicons#FileType(...) abort
            return g:airline_symbols.space . WebDevIconsGetFileTypeSymbol() . g:airline_symbols.space
        endfunction

        return 1
    elseif exists("g:AirlineWebDevIconsFind")
        function! airline_settings#devicons#FileType(...) abort
            return g:airline_symbols.space . g:AirlineWebDevIconsFind(bufname('%')) . g:airline_symbols.space
        endfunction

        return 1
    endif

    return 0
endfunction
