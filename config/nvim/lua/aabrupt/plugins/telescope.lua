return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-live-grep-args.nvim',
  },
  config = function()
    require('telescope').setup {
      extensions = {
        cmdline = {
          picker = {
            layout_config = {
              width = 120,
              height = 25,
            },
          },
          mappings = {
            complete = '<Tab>',
            run_selection = '<C-CR>',
            run_input = '<CR>',
          },
        },
      },
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    vim.keymap.set('n', '<leader>/', function()
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    local builtin = require 'telescope.builtin'
    local utils = require 'telescope.utils'

    vim.keymap.set('n', '<leader>br', builtin.oldfiles, { desc = 'Find [R]ecent Files' })
    vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = 'Find [B]uffers' })
    vim.keymap.set('n', '<leader>bf', function()
      local cwd = vim.fn.expand '%:p:r'
      cwd = cwd:gsub('^.+://', '')
      builtin.find_files { cwd }
    end, { desc = 'Find Relative [F]iles' })
    vim.keymap.set('n', '<leader>bg', builtin.git_files, { desc = 'Find [G]it Files' })
    vim.keymap.set('n', '<leader>bh', builtin.help_tags, { desc = 'Find [H]elp Tags' })
    vim.keymap.set('n', '<leader>bg', function()
      builtin.live_grep { cwd = utils.buffer_dir() }
    end, { desc = 'Live [G]rep' })
    vim.keymap.set('v', '<leader>s', function()
      local saved_reg = vim.fn.getreg 'v'
      vim.cmd [[noautocmd sil norm "vy]]
      local selection = vim.fn.getreg 'v'
      vim.fn.setreg('v', saved_reg)
      builtin.grep_string { cwd = utils.buffer_dir(), search = selection }
    end, { desc = '[S]earch Selection' })
    vim.keymap.set('n', '<leader>bq', function()
      builtin.find_files { cwd = vim.env.HOME .. '/.dotfiles/symlinks', hidden = true }
    end, { desc = 'Find Dotfiles' })
  end,
}
