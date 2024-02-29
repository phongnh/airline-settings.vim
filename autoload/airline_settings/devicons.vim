function! airline_settings#devicons#FileType(...) abort
    return ''
endfunction

function! airline_settings#devicons#Detect() abort
    if findfile('autoload/nerdfont.vim', &rtp) != ''
        function! airline_settings#devicons#FileType(...) abort
            return get(w:, 'airline_active', 1) ? nerdfont#find() : ''
        endfunction

        return 1
    elseif findfile('plugin/webdevicons.vim', &rtp) != ''
        function! airline_settings#devicons#FileType(...) abort
            return get(w:, 'airline_active', 1) ? WebDevIconsGetFileTypeSymbol() : ''
        endfunction

        return 1
    elseif exists("g:AirlineWebDevIconsFind")
        function! airline_settings#devicons#FileType(...) abort
            return get(w:, 'airline_active', 1) ? g:AirlineWebDevIconsFind(bufname('%')) : ''
        endfunction

        return 1
    endif

    return 0
endfunction
