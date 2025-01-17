-- Autocompletion
return {
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      lazy = true,
      build = (function()
        -- Build Step is needed for regex support in snippets
        -- This step is not supported in many windows environments
        -- Remove the below condition to re-enable on windows
        if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),

    },
    'saadparwaiz1/cmp_luasnip',

    -- Adds other completion capabilities.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local cmp = require('cmp')
    local cmp_insert = { behavior = cmp.SelectBehavior.Select }
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').load({ paths = './my-snippets' })
    local luasnip = require('luasnip')
    luasnip.config.setup({})

    local kind_icons = {
      Text = '󰉿',
      Method = 'm',
      Function = '󰊕',
      Constructor = '',
      Field = '',
      Variable = '󰆧',
      Class = '󰌗',
      Interface = '',
      Module = '',
      Property = '',
      Unit = '',
      Value = '󰎠',
      Enum = '',
      Keyword = '󰌋',
      Snippet = '',
      Color = '󰏘',
      File = '󰈙',
      Reference = '',
      Folder = '󰉋',
      EnumMember = '',
      Constant = '󰇽',
      Struct = '',
      Event = '',
      Operator = '󰆕',
      TypeParameter = '󰊄',
    }

    local function cmp_map(rhs, modes)
      if (modes == nil) then
        modes = { 'i', 'c' }
      else
        if (type(modes) ~= 'table')
        then
          modes = { modes }
        end
      end
      return cmp.mapping(rhs, modes)
    end

    local function toggle_complete()
      return function()
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      end
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },
      -- window = {
      --   completion = cmp.config.window.bordered(),
      --   documentation = cmp.config.window.bordered(),
      -- },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-j>'] = cmp_map(cmp.mapping.select_next_item(cmp_insert)),
        ['<C-k>'] = cmp_map(cmp.mapping.select_prev_item(cmp_insert)),
        ['<C-u>'] = cmp_map(cmp.mapping.scroll_docs(-4)),
        ['<C-d>'] = cmp_map(cmp.mapping.scroll_docs(4)),
        ['<C-c>'] = cmp_map(toggle_complete(), { 'i', 'c', 's' }),

        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),

        -- Select next/previous item with Tab / Shift + Tab
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),

      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      },

      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
          -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
          vim_item.menu = ({
            nvim_lsp = '[LSP]',
            luasnip = '[Snippet]',
            buffer = '[Buffer]',
            path = '[Path]',
          })[entry.source.name]
          return vim_item
        end,
      },
    })

    -- Use buffer source for `/` (searching)
    cmp.setup.cmdline('/', {
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for `:`
    cmp.setup.cmdline(':', {
      sources = cmp.config.sources(
        {
          { name = 'path' }
        },
        {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            },
          },
        },
        {
          {
            name = "lazydev",
            group_index = 0, -- Skip loading lua_ls completions
          }
        }
      )
    })
  end,
}
