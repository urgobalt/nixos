return {
    "lewis6991/hover.nvim",
    config = function()
        local hover = require("hover")
        hover.setup({
            init = function()
                require("hover.providers.lsp")
            end,
            preview_opts = {
                border = "single",
            },
            preview_window =true,
            title = false,
        })

        vim.keymap.set("n", "K", hover.hover, {desc="Hover Symbol"})
        vim.keymap.set("n", "gK", hover.hover_select, {desc="Select Information Provider And Hover"})
    end
}
