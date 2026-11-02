require("nvim-treesitter").setup({
    ensure_installed = { "help", "javascript", "typescript", "c", "lua" },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
})
