return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                vim.keymap.set({ "n", "v" }, "]c", function()
                    if vim.wo.diff then
                        return ']c'
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return '<Ignore>'
                end, { buffer = bufnr, expr = true, desc = "Jump To [N]ext Hunk" })

                vim.keymap.set({ "n", "v" }, "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return '<Ignore>'
                end, { buffer = bufnr, expr = true, desc = "Jump To [P]revious Hunk" })

                vim.keymap.set("n", "<leader>gs", gs.stage_hunk,
                    { buffer = bufnr, desc = "Git [S]tage Hunk" })
                vim.keymap.set("n", "<leader>gr", gs.reset_hunk,
                    { buffer = bufnr, desc = "Git [R]eset Hunk" })
                vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk,
                    { buffer = bufnr, desc = "Git [U]ndo Stage Hunk" })
                vim.keymap.set("n", "<leader>gP", gs.preview_hunk,
                    { buffer = bufnr, desc = "[P]review Git Hunk" })

                vim.keymap.set("n", "<leader>gS", gs.stage_buffer,
                    { buffer = bufnr, desc = "Git [S]tage Buffer" })
                vim.keymap.set("n", "<leader>gR", gs.reset_buffer,
                    { buffer = bufnr, desc = "Git [R]eset Buffer" })

                vim.keymap.set("n", "<leader>gb", function()
                    gs.blame_line { full = false }
                end, { buffer = bufnr, desc = "Git [B]lame Line" })

                vim.keymap.set("n", "<leader>gd", gs.diffthis,
                    { buffer = bufnr, desc = "Git [D]iff Against Index" })
                vim.keymap.set("n", "<leader>gD", function()
                    gs.diffthis "~"
                end, { buffer = bufnr, desc = "Git [D]iff Against Last Commit" })

                vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
            end
        })
    end
}
