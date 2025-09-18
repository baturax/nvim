## Plugins:

_None of these are automatically loaded so shouldn't affect startup time that much_

- [nvim-colorizer](https://github.com/catgoose/nvim-colorizer.lua)
- [render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim)
- [yazi](https://github.com/mikavilpas/yazi.nvim)
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
- [ultimate-autopair](https://github.com/altermo/ultimate-autopair.nvim)

## Some Shortcuts
- Ctrl-Space get completion menu(auto triggers already on some like .)
- leader-ca  code actions
- leader-f formats code
- Alt-e yazi

> **_FYI_** neovim has default shortcut shift k try it out

### Tree Sitter setup without plugin:

```
luarocks --lua-version=5.1 --tree=$HOME/.local/share/nvim/rocks install tree-sitter-foo
```

```
mkdir -p $HOME/.local/share/nvim/site/pack/treesitter/start

ln -sf \
  $HOME/.local/share/nvim/rocks/lib/luarocks/rocks-5.1/tree-sitter-foo/fooversion \
  $HOME/.local/share/nvim/site/pack/treesitter/start/tree-sitter-foo
```
