vim.api.nvim_create_user_command("UseTabs",
    function()
        vim.opt.expandtab = false
        print("Enjoy your tabs! :)")
    end,
    { force = true, desc = "Switch to using tabs." }
)

vim.api.nvim_create_user_command("UseSpaces",
    function()
        vim.opt.expandtab = true
        print("Enjoy your spaces! :)")
    end,
    { force = true, desc = "Switch to using spaces." }
)
