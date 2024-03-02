if exists('g:loaded_airline_settings')
    finish
endif
let g:loaded_airline_settings = 1

let s:save_cpo = &cpo
set cpo&vim

call airline_settings#Setup()

if !exists('g:airline_filetype_overrides')
    let g:airline_filetype_overrides = {}
endif

call extend(g:airline_filetype_overrides, {
            \ 'dirvish':         ['Dirvish', '%{airline_settings#dirvish#Folder()}'],
            \ 'molder':          ['Molder', '%{airline_settings#molder#Folder()}'],
            \ 'fern':            ['%{airline_settings#fern#Mode()}', '%{airline_settings#fern#Folder()}'],
            \ 'carbon.explorer': ['Carbon', '%{airline_settings#carbon#Folder()}'],
            \ 'neo-tree':        ['NeoTree', '%{airline_settings#neotree#Folder()}'],
            \ 'oil':             ['Oil', '%{airline_settings#oil#Folder()}'],
            \ 'NvimTree':        ['NvimTree', ''],
            \ 'CHADTree':        ['CHADTree', ''],
            \ 'alpha':           ['Alpha', ''],
            \ })

" Define extra parts
call airline#parts#define_function('status', 'airline_settings#parts#Status')
call airline#parts#define_function('settings', 'airline_settings#parts#Settings')
call airline#parts#define_function('filetype', 'airline_settings#parts#FileType')

" Show only mode, clipboard, paste and spell
let g:airline_section_a = airline#section#create_left([
            \ 'mode',
            \ 'status',
            \ 'crypt',
            \ 'keymap',
            \ 'iminsert',
            \ ])

" Move filetype into other section
let g:airline_section_x = airline#section#create_right([
            \ 'tagbar',
            \ 'gutentags',
            \ 'gen_tags',
            \ 'grepper',
            \ ])

" Add indentation, file encoding, file format and file type info
let g:airline_section_y = airline#section#create_right([
            \ 'settings',
            \ 'filetype',
            \ ])

let g:airline_section_error = airline#section#create([
            \ 'neomake_error_count',
            \ 'ale_error_count',
            \ 'lsp_error_count',
            \ 'nvimlsp_error_count',
            \ 'vim9lsp_error_count',
            \ ])
let g:airline_section_warning = airline#section#create([
            \ 'neomake_warning_count',
            \ 'ale_warning_count',
            \ 'lsp_warning_count',
            \ 'nvimlsp_warning_count',
            \ 'vim9lsp_warning_count',
            \ 'whitespace',
            \ ])

augroup AirlineSettings
    autocmd!
    autocmd User AirlineAfterInit call airline_settings#AirlineAfterInit()
    autocmd VimEnter * call airline_settings#Init()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
