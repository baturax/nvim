## Plugins:

- [nvim-colorizer](https://github.com/catgoose/nvim-colorizer.lua)
- [render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim)

## Some Shortcuts
- <C-space> get completion menu(auto triggers already on some like .)
- <leader>ca  code actions
- <leader>f formats code

> **_FYI_** neovim has default shortcut shift k try it out

### Tree Sitter setup without plugin:

```
luarocks --lua-version=5.1 --tree=$HOME/.local/share/nvim/rocks install tree-sitter-blabla
```

```
mkdir -p $HOME/.local/share/nvim/site/pack/treesitter/start

ln -sf \
  $HOME/.local/share/nvim/rocks/lib/luarocks/rocks-5.1/tree-sitter-blabla/version \
  $HOME/.local/share/nvim/site/pack/treesitter/start/tree-sitter-rust
```

Current startup time: 021.397
