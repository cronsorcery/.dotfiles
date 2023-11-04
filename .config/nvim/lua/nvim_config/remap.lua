local is_multibuffer = function()
    local buffers = vim.api.nvim_list_bufs()
    local n_loaded_buffers = 0

    for _, buffer in ipairs(buffers) do
        if vim.api.nvim_buf_is_loaded(buffer) then
            n_loaded_buffers = n_loaded_buffers + 1
        end
        if n_loaded_buffers >= 2 then
            return true
        end
    end

    return false
end
-- leader is SPACE
vim.g.mapleader = " "

-- SHIFT moves one buffer ahead
-- SHIFT-TAB will go back one buffer
vim.keymap.set("n", "<TAB>", function()
    return is_multibuffer() and vim.cmd.bnext()
end)
vim.keymap.set("n", "<S-TAB>", function()
    return is_multibuffer() and vim.cmd.bprevious()
end)
vim.keymap.set("n", "<leader>cw", [[:bp<bar>sp<bar>bn<bar>bd!<CR>]])


-- LEADER+ex will launch netrw
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

-- Save buffer with Cntrl+s
vim.keymap.set("n", "<C-s>", vim.cmd.w)


-- Leader+s replace string in file (with selection too)
vim.keymap.set("n", "<leader>s", [[
    :%s/\(<C-r><C-w>\)/\1/cgI<Left><Left><Left><Left>]])
vim.keymap.set("v", "<leader>s", vim.fn.expand([[
    :s///cgI<Left><Left><Left><Left><Left>]]))


-- Multiple window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
-- Resize window (NOTE: <M- stands for alt/meta, go figure lol)
vim.keymap.set("n", "<M-j>", ":resize -2<CR>")
vim.keymap.set("n", "<M-k>", ":resize +2<CR>")
vim.keymap.set("n", "<M-l>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<M-h>", ":vertical resize +2<CR>")


-- Move stuf around, carry even.
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv")

-- Indent stuff (shift+>|<)
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move half screen, keep cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


-- Open interactive terminal
vim.keymap.set("n", "<leader>t", "<cmd>terminal<CR>")
-- Exit Insert mode in terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-N>")

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Do the thingy go fmt does on structs
vim.keymap.set("v", "<leader>t", ":!column --table<CR>")
