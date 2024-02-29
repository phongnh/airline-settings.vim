" https://github.com/nvim-neo-tree/neo-tree.nvim
function! airline_settings#neotree#Folder(...) abort
    return exists('b:neo_tree_source') ? b:neo_tree_source : ''
endfunction

