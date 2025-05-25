return {
    {
        "kevinhwang91/nvim-ufo",
        lazy = false,
        dependencies = {
            "kevinhwang91/promise-async",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.foldmethod = "expr"
            vim.o.foldexpr = "nvim_treesitter#foldexpr()"

            require("ufo").setup()

            vim.api.nvim_create_autocmd("BufReadPost", {
                callback = function()
                    require("ufo").enable()
                end,
            })
        end,
    },
}
