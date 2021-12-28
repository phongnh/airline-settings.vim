scriptencoding utf-8

if !get(g:, 'loaded_lsp_settings', 0)
    finish
endif

function! airline#extensions#lsp_settings#apply(...)
    if &buftype == 'nofile' && bufname('%') == '__LSP_SETTINGS__'
        call airline#extensions#apply_left_override('LSP Settings', '')
        return
    endif
endfunction

function! airline#extensions#lsp_settings#init(ext)
    call a:ext.add_statusline_func('airline#extensions#lsp_settings#apply')
endfunction
