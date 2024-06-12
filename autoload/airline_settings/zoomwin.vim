" https://github.com/phongnh/ZoomWin
function! airline_settings#zoomwin#Status(zoomstate) abort
    for F in g:airline_zoomwin_funcref
        if type(F) == v:t_func && F != function('airline_settings#zoomwin#Status')
            call F(a:zoomstate)
        endif
    endfor
    let g:airline_zoomed = a:zoomstate
endfunction
