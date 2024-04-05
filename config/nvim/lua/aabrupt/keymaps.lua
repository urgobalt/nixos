-- How do you exit Neovim?
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = '[W]rite Current Buffer To File' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = '[Q]uit Current Buffer' })
vim.keymap.set('n', '<leader>Q', ':q<CR>', { desc = '[Q]uit All Open Buffers' })
vim.keymap.set('n', '<C-q>', ':q!<CR>', { desc = 'Force [Q]uit Current Buffer' })
vim.keymap.set({'i', 't', 'x', 'v'}, '<C-q>', function() vim.api.nvim_input('<C-\\><C-n>') end, {})

-- Regex substitution shortcuts
vim.keymap.set('v', 'T', ':s/\\<./\\u&/g<CR>', {})

vim.cmd.vmap('K', '<Nop>')
