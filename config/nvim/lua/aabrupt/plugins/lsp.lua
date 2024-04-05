return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    {
      'j-hui/fidget.nvim',
      config = function()
        require('fidget').setup {
          notification = { window = { winblend = 0, x_padding = 1 } },
          progress = { display = { done_icon = ' ' } },
        }
      end,
    },
    'folke/neodev.nvim',
    'nvim-telescope/telescope.nvim',
    {
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
          'L3MON4D3/LuaSnip',
          version = 'v2.2',
          build = 'make install_jsregexp',
        },
        'saadparwaiz1/cmp_luasnip',

        -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',

        -- Adds a number of user-friendly snippets
        'rafamadriz/friendly-snippets',
      },
    },
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup()
    require('neodev').setup()

    local function get_git_root()
      local dot_git_path = vim.fn.finddir('.git', '.;')
      return vim.fn.fnamemodify(dot_git_path, ':h')
    end

    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- html = { filetypes = { 'html', 'twig', 'hbs'} },

      ['ocamllsp'] = {},
      tsserver = {},
      rust_analyzer = {
        ['rust-analyzer'] = {
          rustfmt = {
            extraArgs = { '--config', 'max_width=80' },
          },
        },
      },
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      sqlls = {
        root_dir = function()
          return vim.loop.cwd()
        end,
      },
      intelephense = {
        stubs = {
          'bcmath',
          'bz2',
          'calendar',
          'Core',
          'curl',
          'zip',
          'zlib',
          'wordpress',
          'woocommerce',
          'acf-pro',
          'wordpress-globals',
          'wp-cli',
          'genesis',
          'polylang',
        },
        environment = {
          rootDirectory = get_git_root(),
        },
      },
    }

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    local on_attach = function(_, bufnr)
      local telescope = require 'telescope.builtin'

      -- Buffer Update
      vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Lsp [R]ename Symbol' })
      vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Lsp Code [A]ction' })
      vim.keymap.set('n', '<leader>lq', function()
        vim.lsp.buf.code_action { context = { only = { 'quickfix' } } }
      end, { buffer = bufnr, desc = 'LSP Code [Q]uickfix' })
      vim.keymap.set('n', '<leader>lI', function()
        vim.lsp.buf.code_action { context = { only = { 'refactor.inline' } } }
      end, { buffer = bufnr, desc = 'LSP [I]nline Code Action' })

      -- Help
      vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature [H]elp' })

      -- Telescope
      vim.keymap.set('n', 'gd', telescope.lsp_definitions, { buffer = bufnr, desc = 'Goto Definition' })
      vim.keymap.set('n', 'gr', telescope.lsp_references, { buffer = bufnr, desc = 'Goto References' })
      vim.keymap.set('n', 'gI', telescope.lsp_implementations, { buffer = bufnr, desc = 'Goto Implementation' })
      vim.keymap.set('n', '<leader>lD', telescope.lsp_type_definitions, { buffer = bufnr, desc = 'LSP Type [D]efinition' })
      vim.keymap.set('n', '<leader>ls', telescope.lsp_document_symbols, { buffer = bufnr, desc = 'Document Symbols' })
      vim.keymap.set('n', '<leader>lS', telescope.lsp_workspace_symbols, {
        buffer = bufnr,
        desc = 'Workspace Symbols',
      })
    end

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end,
    }

    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()

    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 's', 'i' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 's', 'i' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
    }
  end,
}
