local augroup = vim.api.nvim_create_augroup

local remove_trailing_space_group = augroup('RemoveTrailingSpace', {})
local yank_group = augroup('HighlightYank', {})

function R(name)
  require('plenary.reload').reload_module(name)
end

vim.api.nvim_create_user_command('Reload', R, { nargs = '?' })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 100,
    }
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = remove_trailing_space_group,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

-- vim.api.nvim_create_autocmd('BufRead', {
--   group = AabruptGroup,
--   pattern = '*',
--   command = [[normal zR]],
-- })
