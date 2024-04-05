return {
    "folke/which-key.nvim",
    config = function()
        local wk = require('which-key')
        wk.register({
            ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
            ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
            ['<leader>m'] = { name = "[M]ode", _ = 'which_key_ignore' },
            ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
            ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        })

        wk.register({
            ['<leader>'] = { name = "VISUAL <leader>" },
            -- ['<leader>g'] = { name = "[G]it", _ = "which_key_ignore" },
        }, { mode = "v" })
    end
}
