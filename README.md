# lua-supercollider-snippets

![in action](assets/rest.gif)

Supercollider snippets for the [snippets.nvim](https://github.com/norcalli/snippets.nvim) neovim plugin.

# Installation
Using vim-plug:

```vim
Plug 'madskjeldgaard/lua-supercollider-snippets'
Plug 'norcalli/snippets.nvim'
```

# Usage
See all snippets available:

`lua require'supercollider-snippets.utils'.print_all()`

Type one of these names and expand using whatever key you have mapped in snippets.nvim

## Options

```lua 
-- Length of random sequences
vim.g.default_sequence_length = 4

-- Newline items in lists
vim.g.supercollider_snippet_comma_newline = 1
```
