function! airline_settings#Trim(str) abort
    return substitute(a:str, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

if exists('*trim')
    function! airline_settings#Trim(str) abort
        return trim(a:str)
    endfunction
endif

function! airline_settings#Concatenate(parts, ...) abort
    let separator = get(a:, 1, 0) ? g:airline_right_alt_sep : g:airline_left_alt_sep
    return join(filter(copy(a:parts), 'v:val !=# ""'), g:airline_symbols.space . separator . g:airline_symbols.space)
endfunction

function! airline_settings#AirlineAfterInit() abort
    setglobal showtabline=1 noshowmode

    " Integrate with ZoomWin
    let g:airline_section_c .= '%{airline_settings#parts#ZoomedStatus()}'

    " Integrate with gutentags and grepper
    let g:airline_section_x = airline#section#create_right([
                \ 'gutentags',
                \ 'grepper',
                \ ])

    " call airline#parts#define_condition('gutentags', 'g:loaded_gutentags == 1')
    " call airline#parts#define_condition('grepper', 'g:loaded_grepper == 1')

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

    call airline#parts#define('longlineinfo', {
                \ 'raw':    '%4l:%-3v %P',
                \ 'accent': 'bold',
                \ })

    call airline#parts#define('simplelineinfo', {
                \ 'raw':    '%3l:%-3v',
                \ 'accent': 'bold',
                \ })

    call airline#parts#define('lineinfo', {
                \ 'raw':    '%4l:%-3v',
                \ 'accent': 'bold',
                \ })

    call airline#parts#define('fulllineinfo', {
                \ 'raw':    '%4l:%-3v %P',
                \ 'accent': 'bold',
                \ })

    if g:airline_show_linenr > 0
        if g:airline_show_linenr > 2
            let g:airline_section_z = airline#section#create(['fulllineinfo'])
        elseif g:airline_show_linenr > 1
            let g:airline_section_z = airline#section#create(['lineinfo'])
        else
            let g:airline_section_z = airline#section#create(['simplelineinfo'])
        endif
    else
        " Hide percentage, linenr, maxlinenr and column
        let g:airline_section_z = ''
    endif
endfunction

function! airline_settings#Init() abort
    " Disable vim-devicons integration for Airline's statusline
    let g:webdevicons_enable_airline_statusline = 0

    " ZoomWin Integration
    let g:airline_zoomed = 0

    if exists(':ZoomWin') == 2
        let g:airline_zoomwin_funcref = []

        if exists('g:ZoomWin_funcref')
            if type(g:ZoomWin_funcref) == v:t_func
                let g:airline_zoomwin_funcref = [g:ZoomWin_funcref]
            elseif type(g:ZoomWin_funcref) == v:t_func
                let g:airline_zoomwin_funcref = g:ZoomWin_funcref
            endif
            let g:airline_zoomwin_funcref = uniq(copy(g:airline_zoomwin_funcref))
        endif

        let g:ZoomWin_funcref = function('airline_settings#zoomwin#Status')
    endif

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
