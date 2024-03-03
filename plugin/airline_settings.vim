if exists('g:loaded_airline_settings')
    finish
endif
let g:loaded_airline_settings = 1

let s:save_cpo = &cpo
set cpo&vim

call airline_settings#Setup()
call airline_settings#SetupSection()

augroup AirlineSettings
    autocmd!
    autocmd User AirlineAfterInit call airline_settings#AirlineAfterInit()
    autocmd VimEnter * call airline_settings#Init()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
