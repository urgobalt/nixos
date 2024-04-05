return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      default_file_explorer = true,
      columns = {
        'icon',
        'permissions',
      },
      delete_to_trash = true,
      lsp_file_methods = {
        autosave_changes = true,
      },
      buf_options = {
        buflisted = false,
        bufhidden = 'hide',
      },
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Explore Current Directory' })
  end,
}
