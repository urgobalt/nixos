return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gv", vim.cmd.Git, {desc = "Git [V]iew"})
        vim.keymap.set("n", "<leader>gp", function ()
            vim.cmd.Git({"push"})
        end, {desc="Git [P]ush"})
        vim.keymap.set("n", "<leader>gd", function ()
            vim.cmd.Git({"pull --rebase"})
        end, {desc="Git [P]ull"})
        vim.keymap.set("n", "<leader>gU", function ()
            vim.cmd.Git({"push -u origin HEAD"})
        end, {desc="Push and Set [U]pstream"})
    end
}
