return {
    "folke/trouble.nvim",
    config = function()
        vim.keymap.set("n", "<leader>ld",
            function() require("trouble").toggle("workspace_diagnostics") end,
            { desc = "Toggle [D]iagnostics" })
    end
}
