local cmp = require'cmp'
local luasnip = require("luasnip")


cmp.setup({
   preselect = cmp.PreselectMode.None,

    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {

   ['<CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            if luasnip.expandable() then
                luasnip.expand()
            else
                cmp.confirm({
                    select = true,
                })
            end
        else
            fallback()
        end
    end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

  },

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = "copilot", group_index = 2 },
    })
  })


  --cmp.setup.cmdline({ '/', '?' }, {
    --mapping = cmp.mapping.preset.cmdline(),
    --sources = {
      --{ name = 'buffer' }
    --}
  --})

  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  require'lspconfig'.v_analyzer.setup{
     capabilities = capabilities
  }

   require'lspconfig'.cssls.setup{
     capabilities = capabilities
   }

   require'lspconfig'.lua_ls.setup {
     capabilities = capabilities
   }

   require'lspconfig'.bashls.setup {
      capabilities = capabilities
   }
   require'lspconfig'.kotlin_language_server.setup {
      capabilities = capabilities
   }

   require'lspconfig'.clangd.setup {
      capabilities = capabilities
   }

   require'lspconfig'.superhtml.setup {
      capabilities = capabilities
   }

   require'lspconfig'.html.setup {
      capabilities = capabilities,
   }

   require'lspconfig'.basedpyright.setup {
      capabilities = capabilities,
   }

   require'lspconfig'.ts_ls.setup {
      capabilities = capabilities,
   }

   require'lspconfig'.fortls.setup{}
