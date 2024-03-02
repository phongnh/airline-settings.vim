function! airline_settings#Trim(str) abort
    return substitute(a:str, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

if exists('*trim')
    function! airline_settings#Trim(str) abort
        return trim(a:str)
    endfunction
endif

function! airline_settings#IsClipboardEnabled() abort
    return match(&clipboard, 'unnamed') > -1
endfunction

function! airline_settings#IsCompact() abort
    return &spell || &paste || airline_settings#IsClipboardEnabled() || winwidth(0) <= g:airline_winwidth_config.xsmall
endfunction

function! airline_settings#AfterInit() abort
    setglobal showtabline=1 noshowmode

    " Overwrite for Terminal
    call airline#parts#define('linenr', {
                \ 'raw':    '%l',
                \ 'accent': 'bold',
                \ })

    " Overwrite for Terminal
    call airline#parts#define('maxlinenr', {
                \ 'raw':    '/%L',
                \ 'accent': 'bold',
                \ })

    if g:airline_show_linenr > 0
        if g:airline_show_linenr > 2
            let l:format = '%4l:%-3v %P'
        elseif g:airline_show_linenr > 1
            let l:format = '%4l:%-3v' 
        else
            let l:format = '%3l:%-3v'
        endif
        call airline#parts#define('lineinfo', {
                    \ 'raw':    l:format,
                    \ 'accent': 'bold',
                    \ })
        let g:airline_section_z = airline#section#create(['lineinfo'])
    else
        " Hide percentage, linenr, maxlinenr and column
        let g:airline_section_z = ''
    endif
endfunction

function! airline_settings#Init() abort
    " Copied from https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/extensions/tabline/formatters/default.vim
    " Show buffer nr in Buffers mode
    function! airline#extensions#tabline#formatters#default#wrap_name(bufnr, buffer_name) abort
        let buf_nr_format = get(g:, 'airline#extensions#tabline#buffer_nr_format', '%s: ')
        let buf_nr_show = tabpagenr('$') == 1

        let _ = buf_nr_show ? printf(buf_nr_format, a:bufnr) : ''
        let _ .= substitute(a:buffer_name, '\\', '/', 'g')

        if getbufvar(a:bufnr, '&modified') == 1
            let _ .= g:airline_symbols.modified
        endif
        return _
    endfunction
endfunction
