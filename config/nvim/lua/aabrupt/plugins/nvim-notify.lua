return {
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup({
            render = "minimal",
            background_colour = "#00000000",
        })
    end
}
