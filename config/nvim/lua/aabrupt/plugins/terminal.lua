return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local toggleterm = require 'toggleterm'
    toggleterm.setup {}

    local main_dir = 'git_dir'
    vim.keymap.set('n', '<leader>tf', function()
      toggleterm.toggle(1, nil, main_dir, 'float', 'Main')
    end, { desc = 'Toggle main terminal as float' })
    vim.keymap.set('n', '<leader>tt', function()
      toggleterm.toggle(1, nil, nil, 'tab', 'Main')
    end, { desc = 'Toggle main terminal' })
    vim.keymap.set('t', '<C-q>', function()
      toggleterm.toggle_all(false)
    end)
  end,
}
